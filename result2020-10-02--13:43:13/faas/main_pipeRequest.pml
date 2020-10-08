
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example247419907/watchdog/handler.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int wgCount = 5;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!wgCount;
	run Anonymous0(wg);
	
	if
	:: true -> 
		run Anonymous1(wg)
	:: true -> 
		run Anonymous2(wg)
	:: true -> 
		run Anonymous2(wg)
	fi;
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi
stop_process:}

proctype Anonymous0(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Wgdef wg) {
	bool closed; 
	int i;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Wgdef wg) {
	bool closed; 
	int i;
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
