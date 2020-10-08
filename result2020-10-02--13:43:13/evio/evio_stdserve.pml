
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131532880/evio_std.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_lnwg;
	int i;
	int s_loops = 5;
	Wgdef s_loopwg;
	int numLoops = 5;
	int s_lns = 5;
	bool state = false;
	run wgMonitor(s_loopwg);
	run wgMonitor(s_lnwg);
	
	if
	:: true -> 
				for(i : 1.. listeners) {
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
		for(i : 1.. s_loops) {
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
		for(i : 1.. s_loops) {
for50:
	};
	s_loopwg.Wait?0
stop_process:}

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
