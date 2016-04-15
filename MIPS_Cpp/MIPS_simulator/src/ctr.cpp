#include "ctr.hpp"
#include "env.hpp"
using namespace Env;

namespace MIPS {
	void Ctr::onChange() {
		if (in[opCode] == B("000000")) { 
			setOutput(jump, 0);
			setOutput(regDst, 1);
			setOutput(ALUSrc, 0);
			setOutput(memToReg, 0);
			setOutput(regWrite, 1);
			setOutput(memRead, 0);
			setOutput(memWrite, 0);
			setOutput(branch, 0);
			setOutput(aluOp, B("10"));
		} else if (in[opCode] == B("000010")) { 
			setOutput(jump, 1);
			setOutput(regDst, 0);
			setOutput(ALUSrc, 0);
			setOutput(memToReg, 0);
			setOutput(regWrite, 0);
			setOutput(memRead, 0);
			setOutput(memWrite, 0);
			setOutput(branch, 0);
			setOutput(aluOp, B("00") );
		} else if (in[opCode] == B("100011")) {
			setOutput(jump, 0);
			setOutput(regDst, 0);
			setOutput(ALUSrc, 1);
			setOutput(memToReg, 1);
			setOutput(regWrite, 1);
			setOutput(memRead, 1);
			setOutput(memWrite, 0);
			setOutput(branch, 0);
			setOutput(aluOp, B("00"));
		} else if (in[opCode] == B("101011")) { 
			setOutput(jump, 0);
			setOutput(regDst, 0);
			setOutput(ALUSrc, 1);
			setOutput(memToReg, 0);
			setOutput(regWrite, 0);
			setOutput(memRead, 0);
			setOutput(memWrite, 1);
			setOutput(branch, 0);
			setOutput(aluOp, B("00") );
		} else if (in[opCode] == B("000100")) { 
			setOutput(jump, 0);
			setOutput(regDst, 0);
			setOutput(ALUSrc, 0);
			setOutput(memToReg, 0);
			setOutput(regWrite, 0);
			setOutput(memRead, 0);
			setOutput(memWrite, 0);
			setOutput(branch, 1);
			setOutput(aluOp, B("01"));
		} else if (in[opCode] == B("001000")) { 
			setOutput(jump, 0);
			setOutput(regDst, 0);
			setOutput(ALUSrc, 1);
			setOutput(memToReg, 0);
			setOutput(regWrite, 1);
			setOutput(memRead, 0);
			setOutput(memWrite, 0);
			setOutput(branch, 0);
			setOutput(aluOp, B("00"));
		}
	}
}
