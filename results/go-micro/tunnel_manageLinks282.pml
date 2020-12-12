#define manageLinks_connect  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example249253371/tunnel/default.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int connect = manageLinks_connect;
	Wgdef wg;
	bool state = false;
	int delLinks = -2;
	int i;
	
	if
	:: true -> 
				for(i : 0.. delLinks-1) {
for30:
		}
	:: true;
	fi;
	run wgMonitor(wg);
		for(i : 0.. connect-1) {
for40:		wg.Add!1;
		run Anonymous0(wg)
	};
	wg.Wait?0
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
