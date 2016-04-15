#include "alu.hpp"
#include "env.hpp"
using namespace Env;

namespace MIPS {
	void ALU::onChange() {
		LineData res = 0;
		if (in[aluCtr] == 0) {
			res = in[input1] & in[input2];
		} else if (in[aluCtr] == B("0000")) {
			res = in[input1] & in[input2];
		} else if (in[aluCtr] == B("0001")) {
			res = in[input1] | in[input2];
		} else if (in[aluCtr] == B("0010")) {
			res = in[input1] + in[input2];
		} else if (in[aluCtr] == B("0110")) {
			res = in[input1] - in[input2];
		} else if (in[aluCtr] == B("0111")) {
			res = (in[input1] < in[input2]) ? 1 : 0;
		} else if (in[aluCtr] == B("1100")) {
			res = ~(in[input1] | in[input2]);
		}
		setOutput(aluRes, res);
		if (res == 0) setOutput(zero, 1);
		else setOutput(zero, 0);
	}
}
