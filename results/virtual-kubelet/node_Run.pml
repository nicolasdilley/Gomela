
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example306226755/node/podcontroller.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. podSyncWorkers-1) {
for10:		wg.Add!1;
		run Anonymous0()
	};
for10_exit:		for(i : 0.. podSyncWorkers-1) {
for20:		wg.Add!1;
		run Anonymous1()
	};
for20_exit:		for(i : 0.. podSyncWorkers-1) {
for30:		wg.Add!1;
		run Anonymous2()
	};
for30_exit:	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous2() {
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
