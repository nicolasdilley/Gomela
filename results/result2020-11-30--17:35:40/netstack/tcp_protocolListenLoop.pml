#define lb_for604_0  -1
#define ub_for604_1  -1

// /tmp/clone-example525661770/tcpip/transport/tcp/accept.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef ctx_pending;
	bool state = false;
	run wgMonitor(ctx_pending);
	do
	:: true -> 
for10:		

		if
		:: true -> 
			break
		fi
	od;
for10_exit:
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
	od
}
