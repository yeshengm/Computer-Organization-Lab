#pragma once
#include "component.hpp"

namespace MIPS {
class Multiplexer: public BaseComponent {
    public:
	Multiplexer(string name = "Mux") : BaseComponent(name) {}
	// Overwrite onChange function
	virtual void onChange();
};

class SignExtener: public BaseComponent {
    public:
	SignExtener() : BaseComponent("SignExtener") {}
	// Overwrite onChange function
	virtual void onChange();
};

class Buffer: public BaseComponent {
    public:
	Buffer() : BaseComponent("Buffer") {}
	virtual void onClock();
};
}
