
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example862180471/go/vt/wrangler/reparent.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int tabletMap = 5;
	Wgdef wgReplicas;
	bool state = false;
	Wgdef wgMaster;
	int masterTabletMap = 5;
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
		for(i : 1.. masterTabletMap) {
for10:
	};
	
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
		for(i : 1.. tabletMap) {
for20:		wg.Add!1;
		run Anonymous0()
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
		for(i : 1.. tabletMap) {
for30:		
		if
		:: true -> 
			wgMaster.Add!1;
			run Anonymous1()
		:: true -> 
			wgReplicas.Add!1;
			run Anonymous2()
		:: true -> 
			wgReplicas.Add!1;
			run Anonymous2()
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

proctype Anonymous0() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous2() {
	bool closed; 
	int i;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
