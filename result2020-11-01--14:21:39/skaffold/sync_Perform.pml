#define Perform_namespaces 1
#define Perform_pods_Items 1
#define Perform_p_Spec_Containers 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example636999748/pkg/skaffold/sync/sync.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int namespaces = Perform_namespaces;
	bool state = false;
	int p_Spec_Containers = Perform_p_Spec_Containers;
	Wgdef errs_wg;
	int pods_Items = Perform_pods_Items;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(errs_wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. namespaces-1) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. pods_Items-1) {
for11:						for(i : 0.. p_Spec_Containers-1) {
for12:
			}
		}
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

