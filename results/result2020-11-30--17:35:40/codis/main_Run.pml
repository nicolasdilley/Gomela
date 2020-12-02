#define Run_args_connlist  0
#define lb_for132_1  -1
#define ub_for132_2  -1
#define lb_for167_3  -1
#define ub_for167_4  -1

// /tmp/clone-example081971740/extern/deprecated/redis-test/bench/benchmark.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int args_time = -2;
	int args_connlist = Run_args_connlist;
	int i;
	
	if
	:: true -> 
		Wgdef wg;
		run wgMonitor(wg);
				for(i : 0.. args_connlist-1) {
for10:			wg.Add!1;
			run Anonymous0(wg,wg)
		};
		wg.Wait?0
	:: true;
	fi;
	
	if
	:: 0 != -2 && args_time-1 != -3 -> 
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
				for(i : 0.. args_connlist-1) {
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
	bool state;
	
	if
	:: lb_for132_1 != -2 && ub_for132_2 != -2 -> 
				for(i : lb_for132_1.. ub_for132_2) {
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
	bool state;
	
	if
	:: lb_for167_3 != -2 && ub_for167_4 != -2 -> 
				for(i : lb_for167_3.. ub_for167_4) {
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
