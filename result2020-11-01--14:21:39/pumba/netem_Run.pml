#define Run_containers 3
#define Run_cancels 3
#define Run_errs 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example230359838/pkg/chaos/netem/rate.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int containers = Run_containers;
	bool state = false;
	int errs = Run_errs;
	Wgdef wg;
	int cancels = Run_cancels;
	int i;
	
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
	run wgMonitor(wg);
		for(i : 0.. containers-1) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
		for(i : 0.. errs-1) {
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	goto stop_process;
		for(i : 0.. cancels-1) {
for20:
	}
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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

