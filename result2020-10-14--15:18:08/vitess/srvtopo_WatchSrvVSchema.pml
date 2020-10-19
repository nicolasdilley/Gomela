#define lb_for549_0  -1
#define ub_for549_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example994420206/go/vt/srvtopo/resilient_server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!1;
	run Anonymous0();
	wg.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			do
			:: true -> 
for11:				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				break
			od
		:: true -> 
			do
			:: true -> 
for11:				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				break
			od
		fi
	od;
for10_exit:stop_process:
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
	od;
stop_process:
}
