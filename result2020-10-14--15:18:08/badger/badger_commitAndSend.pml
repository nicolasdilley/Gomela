#define commitAndSend_txn_pendingWrites  60
#define commitAndSend_txn_duplicateWrites  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example386370723/txn.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int txn_duplicateWrites = commitAndSend_txn_duplicateWrites;
	Wgdef req_Wg;
	bool state = false;
	int txn_pendingWrites = commitAndSend_txn_pendingWrites;
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
