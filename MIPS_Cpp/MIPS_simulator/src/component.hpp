#pragma once
#include <map>
#include <string>
#include <functional>

namespace MIPS {

using std::string;
using std::map;
using std::multimap;
using std::function;

// Data carried on line
typedef int LineData;
// Triggered when data change
typedef function<void(LineData)> EventListener;

// Interface for component
class IComponent {
public:
	// Set input for component
	virtual void input(string name, LineData data) = 0;
	// Get output for component
	virtual LineData output(string name) = 0;
	// Bind output to function
	virtual void bind(string name, EventListener listener) = 0;
};

// Base class for component
class BaseComponent : public IComponent {
protected:
	// component name for log
	string name;
	map<string, LineData> in, out;
	multimap<string, EventListener> inputEvent, outputEvent;
public:
	BaseComponent(string name = "") : name(name) {}
	// Set input for component
	virtual void input(string name, LineData data);
	// Get output for component
	virtual LineData output(string name);
	// Bind output to function
	virtual void bind(string name, EventListener listener);
	// Get default event listener
	virtual EventListener getListener(string name);
	// Trigger clock event
	virtual void clock();
protected:
	// Run if clock signal received
	virtual void onClock();
	// Run if other input changed
	virtual void onChange();
	// Set output for this component
	virtual void setOutput(string name, LineData data);
	// Register inputEvent
	virtual void on(string name, EventListener listener);

};
// End of namespace
}
