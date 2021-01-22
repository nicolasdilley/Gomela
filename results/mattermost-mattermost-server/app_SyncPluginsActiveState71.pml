#define SyncPluginsActiveState_disabledPlugins  0
#define SyncPluginsActiveState_enabledPlugins  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example036208822/app/plugin.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int enabledPlugins = SyncPluginsActiveState_enabledPlugins;
	int disabledPlugins = SyncPluginsActiveState_disabledPlugins;
	

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
		run wgMonitor(wg);
				for(i : 0.. disabledPlugins-1) {
			for20: skip;
			wg.Add!1;
			run go_Anonymous0(wg);
			for20_end: skip
		};
		for20_exit: skip;
				for(i : 0.. enabledPlugins-1) {
			for30: skip;
			wg.Add!1;
			run go_Anonymous1(wg);
			for30_end: skip
		};
		for30_exit: skip;
		wg.Wait?0
	fi
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

