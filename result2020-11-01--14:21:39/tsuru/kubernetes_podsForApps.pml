#define podsForApps_apps 1
#define podsForApps_appSel 1
#define podsForApps_inSelectorMap 1
#define podsForApps_pods 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example261955616/provision/kubernetes/provisioner.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef controller_wg;
	int pods = podsForApps_pods;
	int appSel = podsForApps_appSel;
	bool state = false;
	int apps = podsForApps_apps;
	int inSelectorMap = podsForApps_inSelectorMap;
	int i;
		for(i : 0.. apps-1) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. appSel-1) {
for11:
		}
	};
		for(i : 0.. inSelectorMap-1) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	run wgMonitor(controller_wg);
	
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
		for(i : 0.. pods-1) {
for30:
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

