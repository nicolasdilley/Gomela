#define stdserve_listeners 1
#define stdserve_numLoops 0
#define stdserve_s_loops 0
#define stdserve_s_lns 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example673279353/evio_std.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_loopwg;
	int s_loops = stdserve_s_loops;
	int listeners = stdserve_listeners;
	int i;
	Wgdef s_lnwg;
	int numLoops = stdserve_numLoops;
	int s_lns = stdserve_s_lns;
	bool state = false;
	run wgMonitor(s_loopwg);
	run wgMonitor(s_lnwg);
	
	if
	:: true -> 
				for(i : 0.. listeners-1) {
for10:
		};
		

		if
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	
	if
	:: 0 != -1 && numLoops-1 != -1 -> 
				for(i : 0.. numLoops-1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	s_loopwg.Add!numLoops;
		for(i : 0.. numLoops-1) {
for60:
	};
for60_exit:	s_lnwg.Add!listeners;
		for(i : 0.. listeners-1) {
for70:
	};
for70_exit:	goto stop_process;
		for(i : 0.. s_loops-1) {
for30:
	};
	s_loopwg.Wait?0;
	
	if
	:: 0 != -1 && s_lns-1 != -1 -> 
				for(i : 0.. s_lns-1) {
for40:
		}
	:: else -> 
		do
		:: true -> 
for40:
		:: true -> 
			break
		od
	fi;
for40_exit:	s_lnwg.Wait?0;
	s_loopwg.Add!s_loops;
		for(i : 0.. s_loops-1) {
for50:
	};
	s_loopwg.Wait?0
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

