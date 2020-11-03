#define SyncPluginsActiveState_availablePlugins 1
#define SyncPluginsActiveState_disabledPlugins 1
#define SyncPluginsActiveState_enabledPlugins 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example715326733/app/plugin.go
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
				for(i : 0.. availablePlugins-1) {
for10:
		};
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 0.. disabledPlugins-1) {
for20:			wg.Add!1;
			run Anonymous0(wg)
		};
				for(i : 0.. enabledPlugins-1) {
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
stop_process:	wg.Add!-1
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
stop_process:	wg.Add!-1
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
	od
}

