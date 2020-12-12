#define stdserve_listeners  ??
#define stdserve_numLoops  ??
#define stdserve_s_loops  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example137531308/evio_std.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_lnwg;
	int i;
	int numLoops = stdserve_numLoops;
	Wgdef s_loopwg;
	int listeners = stdserve_listeners;
	int s_loops = stdserve_s_loops;
	bool state = false;
	run wgMonitor(s_loopwg);
	run wgMonitor(s_lnwg);
	
	if
	:: true -> 
				for(i : 0.. listeners-1) {
for10:
		}
	:: true;
	fi;
for20_exit:	s_loopwg.Add!numLoops;
for60_exit:	s_lnwg.Add!listeners;
for70_exit:	goto stop_process;
	s_loopwg.Wait?0;
	s_loopwg.Add!s_loops;
	s_lnwg.Wait?0;
for40_exit:	s_loopwg.Wait?0
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
