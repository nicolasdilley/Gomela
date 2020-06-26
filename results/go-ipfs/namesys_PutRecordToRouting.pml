
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_namesyswaitOnErrChan21 = [0] of {int};
	chan _ch0_in = [2] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	
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
	run Anonymous0(_ch0);
	
	if
	:: true -> 
		run Anonymous1(_ch0);
		chan child_namesyswaitOnErrChan20 = [0] of {int};
		run namesyswaitOnErrChan2(_ch0,child_namesyswaitOnErrChan20);
		child_namesyswaitOnErrChan20?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run namesyswaitOnErrChan2(_ch0,child_namesyswaitOnErrChan21);
	child_namesyswaitOnErrChan21?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
proctype namesyswaitOnErrChan2(Chandef errs;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	child!0;
stop_process:
}
