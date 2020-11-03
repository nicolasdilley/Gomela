#define Stop_sc_Servers 0
#define Stop_sc_Users 0
#define Stop_cmds 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example601413756/upbox/schema.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int sc_Servers = Stop_sc_Servers;
	bool state = false;
	int cmds = Stop_cmds;
	Wgdef wg;
	int sc_Users = Stop_sc_Users;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. sc_Servers-1) {
for10:
	};
		for(i : 0.. sc_Users-1) {
for20:
	};
	run wgMonitor(wg);
		for(i : 0.. cmds-1) {
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
	bool state;
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

