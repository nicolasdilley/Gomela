#define Generate_parsedNodes  60
#define Generate_imports  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example854151717/generator.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int parsedNodes = Generate_parsedNodes;
	Wgdef wg;
	int imports = Generate_imports;
	bool state = false;
	run wgMonitor(wg);
		for(i : 1.. parsedNodes) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
		for(i : 1.. imports) {
for11:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!-1;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od;
stop_process:
}
