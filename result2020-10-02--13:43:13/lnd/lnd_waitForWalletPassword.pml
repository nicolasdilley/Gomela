
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example473489835/lnd.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	int listeners = 5;
	Wgdef wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 1.. listeners) {
for10:		wg.Add!1;
		run Anonymous0(wg)
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. restEndpoints) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		wg.Add!1;
		run Anonymous1(wg)
	};
	wg.Wait?0;
	do
	:: true -> 
		goto stop_process
	od
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
