#define deleteRemovedCronTriggersCronJob_newCronTriggers 1
#define deleteRemovedCronTriggersCronJob_cronJobsToDelete_Items 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example126141555/pkg/platform/kube/functionres/lazy.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int cronJobsToDelete_Items = deleteRemovedCronTriggersCronJob_cronJobsToDelete_Items;
	Wgdef errGroup_wg;
	bool state = false;
	int newCronTriggers = deleteRemovedCronTriggersCronJob_newCronTriggers;
	int i;
		for(i : 0.. newCronTriggers-1) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(errGroup_wg);
		for(i : 0.. cronJobsToDelete_Items-1) {
for20:
	};
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
	od
}

