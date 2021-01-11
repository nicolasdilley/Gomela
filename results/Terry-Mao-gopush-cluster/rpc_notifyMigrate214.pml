#define notifyMigrate_cometNodeInfoMap  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example509780140/rpc/comet.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	int cometNodeInfoMap = notifyMigrate_cometNodeInfoMap;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.Add!cometNodeInfoMap;
		for(i : 0.. cometNodeInfoMap-1) {
		for10: skip;
		run go_Anonymous0(wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		wg.Add!-1;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		wg.Add!-1;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		wg.Add!-1;
		goto stop_process
	:: true;
	fi;
	wg.Add!-1;
	stop_process: skip
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

