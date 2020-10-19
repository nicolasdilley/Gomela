#define Run_containers  60
#define Run_cancels  60
#define Run_errs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example735626009/pkg/chaos/netem/rate.go
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
		for(i : 1.. containers) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
		for(i : 1.. errs) {
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	};
	goto stop_process;
		for(i : 1.. cancels) {
for20:
	}
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
