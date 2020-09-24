#define cmds  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example125472947/upbox/schema.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int sc_Servers = 5;
	bool state = false;
	int cmds = 5;
	Wgdef wg;
	int sc_Users = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	do
	:: true -> 
for20:
	:: true -> 
		break
	od;
	run wgMonitor(wg);
		for(i : 1.. cmds) {
for30:		
		if
		:: true -> 
			wg.Add!1;
			run Anonymous0(wg)
		:: true;
		fi
	};
	wg.Wait?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Wgdef wg) {
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
