
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_processWaitForEvent30 = [0] of {int};
	chan _ch0_in = [1] of {int};
	int i;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run processWaitForEvent3(_ch0,child_processWaitForEvent30);
	child_processWaitForEvent30?0;
	do
	:: _ch0.in?0 -> 
		break
	:: true -> 
		goto stop_process
	od
stop_process:}

proctype processWaitForEvent3(Chandef eventC;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	child!0;
stop_process:
}
