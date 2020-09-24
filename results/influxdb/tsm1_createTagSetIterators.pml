#define groups  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example284558253/tsdb/engine/tsm1/engine.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int groups = 5;
	Wgdef wg;
	bool state = false;
	int parallelism = 5;
	int i;
	
	if
	:: 0 != -1 && parallelism-1 != -1 -> 
				for(i : 0.. parallelism-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	run wgMonitor(wg);
		for(i : 1.. groups) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	do
	:: true -> 
for30:
	:: true -> 
		break
	od;
	do
	:: true -> 
for40:
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
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
