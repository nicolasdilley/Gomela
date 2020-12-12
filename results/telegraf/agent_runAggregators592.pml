#define runAggregators_a_Config_Aggregators  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example359059926/agent/agent.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int a_Config_Aggregators = runAggregators_a_Config_Aggregators;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!1;
	run Anonymous0(wg);
		for(i : 0.. a_Config_Aggregators-1) {
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
for20:		do
		:: true -> 
for21:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
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
	od
}
