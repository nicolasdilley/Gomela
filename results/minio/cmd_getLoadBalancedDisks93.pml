#define getLoadBalancedDisks_hashOrder10820  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example268613986/cmd/erasure-common.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int hashOrder10820 = getLoadBalancedDisks_hashOrder10820;
	Wgdef wg;
	bool state = false;
	int hashOrder9821 = -2;
	int i;
	
	if
	:: true -> 
				for(i : 0.. hashOrder9821-1) {
for10:
		};
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. hashOrder10820-1) {
for20:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
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
