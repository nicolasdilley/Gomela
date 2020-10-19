#define podsForApps_apps  60
#define podsForApps_appSel  60
#define podsForApps_inSelectorMap  60
#define podsForApps_pods  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example490499155/provision/kubernetes/provisioner.go
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
		for(i : 1.. apps) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 1.. appSel) {
for11:
		}
	};
		for(i : 1.. inSelectorMap) {
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
		for(i : 1.. pods) {
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
	od;
stop_process:
}
