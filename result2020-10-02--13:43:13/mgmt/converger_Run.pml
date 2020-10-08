#define lb_for164_0  -1
#define ub_for164_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example326115153/converger/converger.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		wg.Add!1;
		run Anonymous0()
	fi;
	do
	:: true -> 
for10:		do
		:: true -> 
			do
			:: true;
			:: true -> 
				goto stop_process
			od
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:	wg.Wait?0
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
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
