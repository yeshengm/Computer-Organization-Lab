#pragma once
#include "component.hpp"

namespace MIPS {
class PC: public BaseComponent {
    private:
	LineData m_pc;
    public:
	PC(LineData initial_pc) : m_pc(initial_pc), BaseComponent("Program Counter") {};
	// Overwrite onChange function
	virtual void onClock();
};
}
