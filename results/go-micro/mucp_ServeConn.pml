#define lb_for179_0  -1
#define ub_for179_1  -1
#define lb_for392_2  -1
#define ub_for392_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example503123265/server/mucp/rpc_server.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	int msg_Header = 5;
	Wgdef wg_lg;
	int s_opts_HdlrWrappers = 5;
	bool state = false;
	run wgMonitor(wg_lg);
		for(i : lb_for179_0.. ub_for179_1) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true;
		fi;
		do
		:: true -> 
for11:
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			
			if
			:: 0 != -1 && s_opts_HdlrWrappers-1 != -1 -> 
								for(i : 0.. s_opts_HdlrWrappers-1) {
for12:
				}
			:: else -> 
				do
				:: true -> 
for12:
				:: true -> 
					break
				od
			fi;
for12_exit:
		:: true;
		fi;
		run Anonymous0();
		run Anonymous1()
	};
for10_exit:
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	do
	:: true -> 
for13:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for13_exit:	

	if
	:: true;
	fi;
stop_process:
}
proctype Anonymous1() {
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
