
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example070058214/plugins/inputs/snmp/snmp.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int s_Tables = 5;
	Wgdef wg;
	bool state = false;
	int s_Agents = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 1.. s_Agents) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. s_Tables) {
for11:
	};
	wg.Add!-1;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
