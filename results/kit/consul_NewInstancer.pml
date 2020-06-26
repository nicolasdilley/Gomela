
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	int i;
	chan child_sgetInstances20 = [0] of {int};
	bool state = false;
	run sgetInstances2(child_sgetInstances20);
	child_sgetInstances20?0;
	goto stop_process
stop_process:}

proctype sgetInstances2(chan child) {
	bool closed; 
	int i;
	chan _ch0_in = [1] of {int};
	Chandef _ch0;
	Chandef _ch1;
	chan _ch0_in = [1] of {int};
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
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
