#define checkCommittedTxn_txnObservations  60
#define checkCommittedTxn_o_KVs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example543475193/pkg/kv/kvnemesis/validator.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int txnObservations = checkCommittedTxn_txnObservations;
	Wgdef batch_commit;
	int o_KVs = checkCommittedTxn_o_KVs;
	bool state = false;
	run wgMonitor(batch_commit);
	
	if
	:: 0 != -1 && txnObservations - 1 != -1 -> 
				for(i : 0.. txnObservations - 1) {
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
for10_exit:		for(i : 1.. txnObservations) {
for20:		
		if
		:: true -> 
			break
		:: true;
		fi
	};
		for(i : 1.. txnObservations) {
for30:		
		if
		:: true -> 
			break
		:: true;
		fi
	}
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
