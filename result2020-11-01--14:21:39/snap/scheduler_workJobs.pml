#define workJobs_prs 3
#define workJobs_pus 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example271604711/scheduler/workflow.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int pus = workJobs_pus;
	Wgdef wg;
	bool state = false;
	int prs = workJobs_prs;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. prs-1) {
for10:		wg.Add!1;
		run go_schedulersubmitProcessJob(wg)
	};
		for(i : 0.. pus-1) {
for20:		wg.Add!1;
		run go_schedulersubmitPublishJob(wg)
	};
	wg.Wait?0
stop_process:}

proctype go_schedulersubmitProcessJob(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:	wg.Add!-1
}
proctype go_schedulersubmitPublishJob(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:	wg.Add!-1
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

