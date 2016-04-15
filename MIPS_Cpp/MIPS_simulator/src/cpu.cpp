#include "cpu.hpp"
#include "component.hpp"
#include "env.hpp"
#include <iostream>

using std::string;
using namespace Env;
using namespace MIPS;
using namespace std;

void BIND(BaseComponent &a, string output, BaseComponent &b, string input)
{
	a.bind(output, b.getListener(input));
}

EventListener partialListener(int start, int end, BaseComponent &comp, string name)
{
	return [=,&comp](LineData data) {
		unsigned int d = data;
		// 10011 << 3 = 11000
		d = d << (31 - end);
		// 11000 >> 3 = 00011
		d = d >> (start + 31 - end);
		comp.input(name, d);
	};
}

namespace MIPS {
	CPU::CPU() : pc(-4), instMem("Instruction Memory"), dataMem("Data Memory"),
		muxMem2Reg("muxMem2Reg"), muxAlu("muxAlu"), muxRegDes("muxRegDes") {
		instMem.bind(readData, partialListener(26, 31, ctr, opCode));
		instMem.bind(readData, partialListener(21, 25, reg, readReg1));
		instMem.bind(readData, partialListener(16, 20, reg, readReg2));
		instMem.bind(readData, partialListener(16, 20, muxRegDes, input1));
		instMem.bind(readData, partialListener(11, 15, muxRegDes, input2));
		instMem.bind(readData, partialListener(0, 15, signExtend, immInput));
		instMem.bind(readData, partialListener(0, 3, aluControl, funct));
		BIND(ctr, jump, pc, branch);
		BIND(ctr, regDst, muxRegDes, muxSel);
		BIND(ctr, branch, pc, branch);
		BIND(ctr, memRead, dataMem, memRead );
		BIND(ctr, memToReg, muxMem2Reg, muxSel);
		BIND(ctr, aluOp, aluControl, aluOp);
		BIND(ctr, ALUSrc, muxAlu, muxSel);
		BIND(ctr, regWrite, reg,  regWrite);   
		BIND(ctr, memWrite, dataMem, memWrite);
		BIND(aluControl, aluCtr, alu, aluCtr);
		BIND(muxRegDes, muxOut, reg, writeReg);
		BIND(muxAlu, muxOut, alu, input2);
		BIND(muxMem2Reg, muxOut, reg, writeData);
		BIND(reg, readData1, alu, input1);
		BIND(reg, readData2, muxAlu, input1);
		BIND(reg, readData2, dataMem, writeData);
		BIND(alu, aluRes, dataMem, address);
		BIND(alu, aluRes, muxMem2Reg, input1);
		BIND(alu, zero, pc, zero);
		BIND(signExtend, immData, muxAlu, input2);
		BIND(signExtend, immData, pc, immData);
		BIND(dataMem, readData, muxMem2Reg, input2);
		BIND(pc, newPC, instMem, address);
		BIND(pc, memRead, instMem, memRead);
	}

	LineData CPU::run()
	{
		int count = 0;
		while (instMem.output(readData) != 0xFFFFFFFF)
		{
			// All program should be terminated in max_cpu_cycle cycles
			count++;
			if (count > max_cpu_cycle)
			{
				break;
			}
			// IF
			pc.clock();
			instMem.clock();
			// Mem
			dataMem.clock();
			// WB
			reg.clock();
#ifdef DEBUG
			reg.logStatus();
#endif
		}
		// Get res
		reg.input(readReg1, 2);
		return reg.output(readData1);
	}

	void CPU::reset()
	{
		// Initialize Program Counter
		pc = PC(-4);
	}
}
