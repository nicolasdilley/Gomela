#define UpdateClientConnState_addrs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example957300984/balancer/grpclb/grpclb.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int addrs = UpdateClientConnState_addrs;
	bool state = false;
	int i;
		for(i : 1.. addrs) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			Wgdef lb_ccRemoteLB_wg;
			run wgMonitor(lb_ccRemoteLB_wg)
		:: true;
		fi
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
