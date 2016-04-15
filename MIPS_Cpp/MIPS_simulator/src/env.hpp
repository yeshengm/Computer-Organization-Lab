#pragma once
#include <string>
#define SC(name) const string name = #name
// #define DEBUG
namespace Env {
    using std::string;
	inline int B(string str) 
	{
		char *ptr;
		return strtol(str.c_str(), &ptr, 2);
	}
	const int max_reg_num = 32;
	const int max_mem_num = 1024;
	const int max_cpu_cycle = 1024;
	// For clock
	SC(clock_in);
	// ALU
	SC(input1);
	SC(input2);
	SC(aluCtr);
	SC(zero);
	SC(aluRes);
	// Ctl
	SC(opCode);
	SC(regDst);
	SC(memToReg);
	SC(regWrite);
	SC(memRead);
	SC(memWrite);
	SC(ALUSrc);
	SC(branch);
	SC(aluOp);
	SC(jump);
	// Reg
	SC(readReg1);
	SC(readReg2);
	SC(writeReg);
	SC(writeData);
	SC(readData1);
	SC(readData2);
	// aluCtr
	SC(funct);
	// PC
	// immediate data for instruction
	SC(immData);
	SC(newPC);
	// Multiplexer
	SC(input3);
	SC(input4);
	SC(muxSel);
	SC(muxOut);
	// Sign Extend
	SC(immInput);
	// Memory
	SC(address);
	SC(readData);
};
