#define runDebugUnsafeRemoveDeadReplicas_removeDeadReplicasOpts_deadStoreIDs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example543475193/pkg/cli/debug.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef stopper_stop;
	int i;
	int removeDeadReplicasOpts_deadStoreIDs = runDebugUnsafeRemoveDeadReplicas_removeDeadReplicasOpts_deadStoreIDs;
	bool state = false;
	run wgMonitor(stopper_stop);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. removeDeadReplicasOpts_deadStoreIDs) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
