#define Start_options 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example195606125/remote/server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int options = Start_options;
	Wgdef s_serveWG;
	int i;
		for(i : 0.. options-1) {
for10:
	};
	run wgMonitor(s_serveWG)
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

