#pragma once
#include "component.hpp"

namespace MIPS {
class Ctr: public BaseComponent {
    public:
	Ctr() : BaseComponent("ctr"){}
	// Overwrite onChange function
	virtual void onChange();
};
}
