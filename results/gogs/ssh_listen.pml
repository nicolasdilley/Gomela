#define lb_for132_0  -1
#define ub_for132_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
		for(i : lb_for132_0.. ub_for132_1) {
for10:		run Anonymous0()
	};
for10_exit:
stop_process:}

proctype go_sshhandleServerConn2(Chandef chans) {
	bool closed; 
	int i;
	do
	:: chans.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			chans.in?0;
			run Anonymous1()
		fi
	od;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	do
	:: reqs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			reqs.in?0;
			

			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				
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
				run Anonymous1();
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto stop_process
			:: true;
			fi
		fi
	od;
stop_process:
}
proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run go_sshhandleServerConn2(chans);
stop_process:
}
