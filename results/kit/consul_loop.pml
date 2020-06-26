#define lb_for69_0  -1
#define ub_for69_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
		for(i : lb_for69_0.. ub_for69_1) {
for10:		chan child_sgetInstances20 = [0] of {int};
		run sgetInstances2(child_sgetInstances20);
		child_sgetInstances20?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		:: true;
		fi
	};
for10_exit:
stop_process:}

proctype sgetInstances2(chan child) {
	bool closed; 
	int i;
	run Anonymous1(interruptc,interruptc);
	do
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: interruptc.in?0 -> 
		goto stop_process
	od;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef interruptc;Chandef interruptc) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		_ch1.in!0;
		goto stop_process
	:: true;
	fi;
	resc.in!0;
stop_process:
}
