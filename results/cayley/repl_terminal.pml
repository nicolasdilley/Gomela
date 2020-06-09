
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	run Anonymous0();
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	Chandef _ch0;
	chan _ch0_in = [1] of {int};
	_ch0.in = _ch0_in;
	_ch0.in?0;
stop_process:
}
