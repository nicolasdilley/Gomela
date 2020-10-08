#define lb_for549_0  -1
#define ub_for549_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example862180471/go/vt/srvtopo/resilient_server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int changes = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!1;
	run Anonymous0();
	wg.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
						for(i : 1.. changes) {
for11:				
				if
				:: true -> 
					break
				:: true;
				fi
			}
		:: true -> 
						for(i : 1.. changes) {
for11:				
				if
				:: true -> 
					break
				:: true;
				fi
			}
		fi
	od;
for10_exit:stop_process:
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
