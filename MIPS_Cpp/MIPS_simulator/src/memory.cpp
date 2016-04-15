#include "memory.hpp"
#include "env.hpp"
using namespace Env;
using std::vector;

namespace MIPS {

Memory::Memory(string name) : BaseComponent(name)
{
	memory.resize(max_mem_num);
}

void Memory::onChange()
{
	if (in[memRead] && in[address] >= 0)
	{
		setOutput(readData, memory[in[address]]);
	}
}

void Memory::onClock()
{
	if (in[memWrite])
	{
		memory[in[address]] = in[writeData];
	}
	onChange();
}

void Memory::loadMemory(int address, LineData data)
{
	memory[address] = data;
}
}
