#pragma once
#include "component.hpp"
#include <vector>
using std::vector;

namespace MIPS {
class Reg: public BaseComponent {
    vector<LineData> memory;
    public:
	Reg();
	// Overwrite onChange function
	virtual void onChange();
	// Overwrite onClock function
	virtual void onClock();
	// Report Status
	void logStatus();
};
}
