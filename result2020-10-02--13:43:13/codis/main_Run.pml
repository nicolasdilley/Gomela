#define lb_for132_0  -1
#define ub_for132_1  -1
#define lb_for167_2  -1
#define ub_for167_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example544091475/extern/deprecated/redis-test/bench/benchmark.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int args_time = 5;
	int args_connlist = 5;
	int i;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 1.. args_connlist) {
for10:			wg.Add!1;
			run Anonymous0(wg,wg)
		};
		wg.Wait?0
	:: true;
	fi;
		for(i : 1.. args_connlist) {
for20:
	};
	
	if
	:: 0 != -1 && args_time-1 != -1 -> 
				for(i : 0.. args_time-1) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 1.. args_connlist) {
for40:			wg.Add!1;
			run Anonymous1(wg,wg)
		};
		wg.Wait?0
	:: true;
	fi
stop_process:}

proctype Anonymous0(Wgdef wg;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: lb_for132_0 != -1 && ub_for132_1 != -1 -> 
				for(i : lb_for132_0.. ub_for132_1) {
for11:
		}
	:: else -> 
		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	fi;
for11_exit:	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: lb_for167_2 != -1 && ub_for167_3 != -1 -> 
				for(i : lb_for167_2.. ub_for167_3) {
for41:
		}
	:: else -> 
		do
		:: true -> 
for41:
		:: true -> 
			break
		od
	fi;
for41_exit:	wg.Add!-1;
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
