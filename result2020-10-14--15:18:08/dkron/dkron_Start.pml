#define Start_jobs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example523163252/dkron/scheduler.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef s_Cron_jobWaiter;
	int i;
	int jobs = Start_jobs;
	bool state = false;
	run wgMonitor(s_Cron_jobWaiter);
		for(i : 1.. jobs) {
for10:
	};
	goto stop_process
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
	od;
stop_process:
}
