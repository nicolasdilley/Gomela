
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example739541781/cmd/ctr/commands/shim/io_unix.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0(wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!1;
	run Anonymous1(wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		wg.Add!1;
		run Anonymous2(wg)
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Wgdef wg) {
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
	od
}
