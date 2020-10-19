#define sendToWriteCh_entries  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example386370723/db.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int entries = sendToWriteCh_entries;
	Wgdef req_Wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. entries) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(req_Wg);
	req_Wg.Add!1;
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
