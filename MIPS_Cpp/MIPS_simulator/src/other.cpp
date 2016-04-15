#include "other.hpp"
#include "env.hpp"
using namespace Env;
namespace MIPS {
void Multiplexer::onChange()
{
	if (in[muxSel] == 0)
	{
		setOutput(muxOut, in[input1]);
	} 
	else if (in[muxSel] == 1)
	{
		setOutput(muxOut, in[input2]);
	}
	else if (in[muxSel] == 2)
	{
		setOutput(muxOut, in[input3]);
	}
	else
	{
		setOutput(muxOut, in[input4]);
	}
};

void SignExtener::onChange()
{
	// Sign Extend
	LineData num = in[immInput];
	LineData sign = (num >> 15) & 1;
	// Fill other place with sign number
	LineData fill = 0;
	if (sign == 1)
	{
		fill = 0xFFFF0000;
	}
	num = num | fill;
	setOutput(immData, num);
};

void Buffer::onClock()
{
	out.clear();
	for (auto it = in.begin(); it != in.end(); ++it)
	{
		setOutput(it->first, it->second);
	}
}
}
