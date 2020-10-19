#define SyncPluginsActiveState_availablePlugins  60
#define SyncPluginsActiveState_disabledPlugins  60
#define SyncPluginsActiveState_enabledPlugins  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example437804699/app/plugin.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int enabledPlugins = SyncPluginsActiveState_enabledPlugins;
	int availablePlugins = SyncPluginsActiveState_availablePlugins;
	bool state = false;
	int disabledPlugins = SyncPluginsActiveState_disabledPlugins;
	int i;
	
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
		fi;
				for(i : 1.. availablePlugins) {
for10:
		};
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 1.. disabledPlugins) {
for20:			wg.Add!1;
			run Anonymous0(wg)
		};
				for(i : 1.. enabledPlugins) {
for30:			wg.Add!1;
			run Anonymous1(wg)
		};
		wg.Wait?0
	fi
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!-1;
stop_process:
}
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
