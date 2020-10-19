#define createTagSetIterators_parallelism  60
#define createTagSetIterators_groups  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example798243311/tsdb/engine/tsm1/engine.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int groups = createTagSetIterators_groups;
	Wgdef wg;
	bool state = false;
	int parallelism = createTagSetIterators_parallelism;
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
		for(i : 1.. groups) {
for30:
	};
		for(i : 1.. groups) {
for40:
	};
	
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
	bool state;
	wg.Add!-1;
stop_process:
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
