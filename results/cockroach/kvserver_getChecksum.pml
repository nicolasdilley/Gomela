
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan child_rchecksumInitialWait31 = [0] of {int};
	bool state = false;
	int i;
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [0] of {int};
		_ch0.in = _ch0_in
	:: true;
	fi;
	run rchecksumInitialWait3(child_rchecksumInitialWait31);
	child_rchecksumInitialWait31?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		chan child_rchecksumWait42 = [0] of {int};
		run rchecksumWait4(child_rchecksumWait42);
		child_rchecksumWait42?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype rchecksumInitialWait3(chan child) {
	bool closed; 
	int i;
	chan child_rchecksumWait40 = [0] of {int};
	run rchecksumWait4(child_rchecksumWait40);
	child_rchecksumWait40?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype rchecksumWait4(chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		break
	:: true -> 
		goto stop_process
	od;
	child!0;
stop_process:
}
