#define lb_for40_0  -1
#define ub_for40_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example175635551/pkg/query/aur_info.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int tempInfo = 5;
	Wgdef wg;
	int info = 5;
	bool state = false;
	run wgMonitor(wg);
		for(i : lb_for40_0.. ub_for40_1) {
for10:		wg.Add!1
	};
for10_exit:	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. info) {
for20:
	};
		for(i : 1.. names) {
for30:
	};
	goto stop_process
stop_process:}

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
