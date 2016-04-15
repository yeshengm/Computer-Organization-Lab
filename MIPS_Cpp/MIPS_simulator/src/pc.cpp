#include "pc.hpp"
#include "env.hpp"
using namespace Env;

namespace MIPS {
	void PC::onClock() {
		m_pc += 4;
		if (in[branch] == 1 && in[zero] == 1) {
			m_pc += in[immData] << 2; 
		}
		setOutput(newPC, m_pc);
		setOutput(memRead, 1);
	}
}
