#define runAggregators_a_Config_Aggregators  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example985353586/agent/agent.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int a_Config_Aggregators = runAggregators_a_Config_Aggregators;
	Wgdef wg;
	int i;
		for(i : 1.. a_Config_Aggregators) {
for10:
	};
	run wgMonitor(wg);
	wg.Add!1;
	run Anonymous0(wg);
		for(i : 1.. a_Config_Aggregators) {
for30:		wg.Add!1;
		run Anonymous1(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:				for(i : 1.. a_Config_Aggregators) {
for21:
		}
	:: true -> 
		break
	od;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
