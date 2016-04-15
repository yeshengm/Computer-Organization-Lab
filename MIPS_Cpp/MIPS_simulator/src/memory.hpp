#pragma once
#include "component.hpp"
#include <vector>
using std::vector;

namespace MIPS {
class Memory: public BaseComponent {
    vector<LineData> memory;
    public:
	Memory(string name = "Memory");
	// Overwrite onChange function
	virtual void onChange();
	// Overwrite onClock function
	virtual void onClock();
	// Set instruction memory
	// For set up of this memeory
	void loadMemory(int address, LineData data);
};
}
