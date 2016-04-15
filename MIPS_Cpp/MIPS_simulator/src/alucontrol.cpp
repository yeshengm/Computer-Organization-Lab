#include "alucontrol.hpp"
#include "env.hpp"
using namespace Env;

namespace MIPS {
	void ALUControl::onChange() {
		if (in[aluOp] == 0)
			setOutput(aluCtr, B("0010"));
		else if (in[aluOp] == B("01")) 
			setOutput(aluCtr, B("0110"));
		else if (in[aluOp] == B("10"))
			if (in[funct] == B("0000"))
				setOutput(aluCtr, B("0010"));
			else if (in[funct] == B("0010"))
				setOutput(aluCtr, B("0110"));
			else if (in[funct] == B("0100"))
				setOutput(aluCtr, B("0000"));
			else if (in[funct] == B("0101"))
				setOutput(aluCtr, B("0001"));
			else if (in[funct] == B("1010"))
				setOutput(aluCtr, B("0111"));
	}
}
