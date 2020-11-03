#define deleteFunctionEvents_result_Items 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example126141555/pkg/platform/kube/functionres/lazy.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef errGroup_wg;
	int i;
	int result_Items = deleteFunctionEvents_result_Items;
	bool state = false;
	run wgMonitor(errGroup_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. result_Items-1) {
for10:
	};
	
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
	od
}

