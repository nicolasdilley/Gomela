
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0();
	goto stop_process
stop_process:}

proctype go_sshDiscardRequests1(Chandef in) {
	bool closed; 
	int i;
	do
	:: in.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			in.in?0
		fi
	od;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous0() {
	bool closed; 
	int i;
		for(i : 1.. channels) {
for10:		run go_sshDiscardRequests1(reqs);
		run Anonymous1()
	};
stop_process:
}
