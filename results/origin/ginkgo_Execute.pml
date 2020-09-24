#define lb_for113_0  -1
#define ub_for113_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example252103968/pkg/test/ginkgo/queue.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int serial = 5;
	Wgdef wg;
	int i;
	run Anonymous0(wg);
	run wgMonitor(wg);
	wg.Add!parallelism;
		for(i : 0.. parallelism-1) {
for10:		run Anonymous1(wg)
	};
for10_exit:	wg.Wait?0;
	do
	:: true -> 
for20:		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		od
	:: true -> 
		break
	od
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: lb_for113_0 != -1 && ub_for113_1 != -1 -> 
				for(i : lb_for113_0.. ub_for113_1) {
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
