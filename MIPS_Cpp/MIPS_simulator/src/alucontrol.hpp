#include "component.hpp"

namespace MIPS {
class ALUControl: public BaseComponent {
    public:
	ALUControl() : BaseComponent("ALUControl") {}
	// Overwrite onChange function
	virtual void onChange();
};
}
