
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
		Chandef _ch0;
		chan _ch0_in = [allocSize] of {int};
		_ch0.in = _ch0_in
	:: true;
	fi
stop_process:}

