#define initShardMasterLocked_tabletMap  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example245190199/go/vt/wrangler/reparent.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wgReplicas;
	Wgdef wgMaster;
	Wgdef wg;
	bool state = false;
	int i;
	int tabletMap = initShardMasterLocked_tabletMap;
	

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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. tabletMap-1) {
		for20: skip;
		wg.Add!1;
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wgMaster);
	run wgMonitor(wgReplicas);
		for(i : 0.. tabletMap-1) {
		for30: skip;
		

		if
		:: true -> 
			wgMaster.Add!1;
			run go_Anonymous0(wg,wgMaster,wgReplicas)
		:: true -> 
			wgReplicas.Add!1;
			run go_Anonymous1(wg,wgMaster,wgReplicas)
		:: true -> 
			wgReplicas.Add!1;
			run go_Anonymous1(wg,wgMaster,wgReplicas)
		fi;
		for30_end: skip
	};
	for30_exit: skip;
	wgMaster.Wait?0;
	

	if
	:: true -> 
		wgReplicas.Wait?0;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			wgReplicas.Wait?0;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	wgReplicas.Wait?0;
	

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
stop_process:skip
}

proctype go_Anonymous0(Wgdef wg;Wgdef wgMaster;Wgdef wgReplicas) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wgMaster.Add!-1
}
proctype go_Anonymous1(Wgdef wg;Wgdef wgMaster;Wgdef wgReplicas) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	wgReplicas.Add!-1
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

