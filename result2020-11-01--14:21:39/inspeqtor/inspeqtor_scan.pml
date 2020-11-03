#define scan_i_Services 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example543530583/testing.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef barrier;
	int i;
	int i_Services = scan_i_Services;
	bool state = false;
	run wgMonitor(barrier);
	barrier.Add!1;
	barrier.Add!i_Services;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	barrier.Wait?0
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

