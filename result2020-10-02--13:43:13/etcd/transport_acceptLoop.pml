#define lb_for125_0  -1
#define ub_for125_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example152234228/pkg/transport/listener_tls.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int pending = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : lb_for125_0.. ub_for125_1) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		wg.Add!1;
		run Anonymous0(wg)
	};
for20_exit:		for(i : 1.. pending) {
for10:
	};
	wg.Wait?0
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true;
	:: true;
	od;
	wg.Add!-1;
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
