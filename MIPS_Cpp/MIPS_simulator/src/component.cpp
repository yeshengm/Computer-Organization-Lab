#include "component.hpp"
#include "env.hpp"
#include <iostream>
using namespace std;

namespace MIPS {
	using namespace Env;
	// Set input for component
	void BaseComponent::input(string name, LineData data)
	{
#ifdef DEBUG
		cout << "[" << this->name << "]"<< "input: " << name << " " << data << endl;
#endif
		// Has previous key
		if (in.find(name) != in.end())
		{
			LineData prevData = in[name];
			if (prevData == data && name != clock_in)
			{
				// No data change
				return;
			}
		}
		in[name] = data;
		auto range = inputEvent.equal_range(name);
		for (auto it = range.first ; it != range.second ; ++it)
		{
			it->second(data);
		}
		if (name != clock_in)
		{
			onChange();
		}
		else 
		{
			onClock();
		}
	}
	// Get output for component
	LineData BaseComponent::output(string name)
	{
		return out[name];
	}
	// Bind output to function
	void BaseComponent::bind(string name, EventListener listener)
	{
		outputEvent.insert(std::make_pair(name, listener));
	}
	// Get default event listener
	EventListener BaseComponent::getListener(string name)
	{
		return [=](LineData data){this->input(name, data);};
	}
	// Run if clock signal received
	void BaseComponent::onClock()
	{
	}
	// Run if other input changed
	void BaseComponent::onChange()
	{
	}
	// Set output for this component
	void BaseComponent::setOutput(string name, LineData data)
	{
#ifdef DEBUG
		cout << "[" << this->name << "]"<< "output: " << name << " " << data << endl;
#endif
		out[name] = data;
		auto range = outputEvent.equal_range(name);
		for (auto it = range.first; it != range.second; ++it)
		{
			it->second(data);
		}
	}
	// Register inputEvent
	void BaseComponent::on(string name, EventListener listener)
	{
		inputEvent.insert(std::make_pair(name, listener));
	}
	// Trigger inputEvent
	void BaseComponent::clock()
	{
		input(clock_in, 1);
	}
}
