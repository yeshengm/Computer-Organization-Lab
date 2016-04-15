#pragma once
#include "component.hpp"

namespace MIPS {
class ALU: public BaseComponent {
    public:
	ALU() : BaseComponent("alu") {};
	// Overwrite onChange function
	virtual void onChange();
};
}
