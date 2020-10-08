
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example121482466/txn.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int txn_duplicateWrites = 5;
	Wgdef req_Wg;
	bool state = false;
	int txn_pendingWrites = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. txn_pendingWrites) {
for10:
	};
		for(i : 1.. txn_duplicateWrites) {
for20:
	};
		for(i : 1.. txn_pendingWrites) {
for30:
	};
		for(i : 1.. txn_duplicateWrites) {
for40:
	};
	run wgMonitor(req_Wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

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
