#define New_cfg_ListenAddrs  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example776713684/watchtower/standalone.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int cfg_ListenAddrs = New_cfg_ListenAddrs;
	Wgdef lookout_wg;
	bool state = false;
	Wgdef server_wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(lookout_wg);
		for(i : 1.. cfg_ListenAddrs) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	run wgMonitor(server_wg);
	
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
	od;
stop_process:
}
