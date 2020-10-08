#define lb_for72_0  -1
#define ub_for72_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example913898336/pkg/queue/bounded_queue.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef startWG;
	int i;
	int q_workers = 5;
	bool state = false;
	run wgMonitor(startWG);
		for(i : 0.. q_workers-1) {
for10:		startWG.Add!1;
		run Anonymous0(startWG)
	};
for10_exit:	startWG.Wait?0
stop_process:}

proctype Anonymous0(Wgdef startWG) {
	bool closed; 
	int i;
	startWG.Add!-1;
	do
	:: true -> 
for11:		do
		:: true -> 
			goto stop_process
		od
	od;
for11_exit:stop_process:
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
