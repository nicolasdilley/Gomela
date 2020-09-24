#define lb_for162_0  -1
#define ub_for162_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example263949331/provision/kubernetes/logs.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int logs = 5;
	Wgdef wg;
	int errs = 5;
	bool state = false;
	run wgMonitor(wg);
	wg.Add!pods;
	do
	:: true -> 
for10:		run Anonymous0(wg)
	:: true -> 
		break
	od;
	wg.Wait?0;
	do
	:: true -> 
for20:
	:: true -> 
		break
	od;
	do
	:: true -> 
for30:
	:: true -> 
		break
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for162_0 != -1 && ub_for162_1 != -1 -> 
				for(i : lb_for162_0.. ub_for162_1) {
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
