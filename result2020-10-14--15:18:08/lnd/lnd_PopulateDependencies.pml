#define PopulateDependencies_numFields  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example653067025/subrpcserver_config.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int numFields = PopulateDependencies_numFields;
	Wgdef s_RouterRPC_Router_wg;
	int i;
	
	if
	:: 0 != -1 && numFields-1 != -1 -> 
				for(i : 0.. numFields-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	run wgMonitor(s_RouterRPC_Router_wg);
	goto stop_process
stop_process:}

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
