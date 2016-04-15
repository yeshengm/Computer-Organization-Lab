#include "reg.hpp"
#include "env.hpp"
using namespace Env;
using std::vector;

namespace MIPS {
	Reg::Reg() : BaseComponent("Register Stack") {
		memory.resize(max_reg_num);
	}
	void Reg::onChange() {
		LineData regA = in[readReg1], regB = in[readReg2];
		setOutput(readData1, memory[regA]);
		setOutput(readData2, memory[regB]);
	}
	void Reg::onClock() {
		onChange();
		if (in[regWrite] == 1) {
			memory[in[writeReg]] = in[writeData];
		}
	}
	void Reg::logStatus() {
		printf("=========================\n");
		printf("Reg value: \n");
		for (int i = 0 ; i != memory.size(); ++i)
		{
			printf("r%d\t:%d\n", i, memory[i]);
		}
		printf("=========================\n");
	}
}
