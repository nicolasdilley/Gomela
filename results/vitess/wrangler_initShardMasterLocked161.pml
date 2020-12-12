#define initShardMasterLocked_tabletMap  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example476275474/go/vt/wrangler/reparent.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wgMaster;
	bool state = false;
	int tabletMap = initShardMasterLocked_tabletMap;
	Wgdef wg;
	Wgdef wgReplicas;
	int i;
	
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
for20:		wg.Add!1;
		run Anonymous0(wg,wgMaster,wgReplicas)
	};
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
for30:		
		if
		:: true -> 
			wgMaster.Add!1;
			run Anonymous1(wg,wgMaster,wgReplicas)
		:: true -> 
			wgReplicas.Add!1;
			run Anonymous2(wg,wgMaster,wgReplicas)
		:: true -> 
			wgReplicas.Add!1;
			run Anonymous2(wg,wgMaster,wgReplicas)
		fi
	};
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
stop_process:}

proctype Anonymous0(Wgdef wg;Wgdef wgMaster;Wgdef wgReplicas) {
	bool closed; 
	int i;
	bool state;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Wgdef wg;Wgdef wgMaster;Wgdef wgReplicas) {
	bool closed; 
	int i;
	bool state;
stop_process:	wgMaster.Add!-1
}
proctype Anonymous2(Wgdef wg;Wgdef wgMaster;Wgdef wgReplicas) {
	bool closed; 
	int i;
	bool state;
stop_process:	wgReplicas.Add!-1
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
