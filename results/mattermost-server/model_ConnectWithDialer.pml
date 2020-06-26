
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch4_in = [100] of {int};
	chan _ch5_in = [100] of {int};
	int i;
	Chandef _ch5;
	Chandef _ch4;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef _ch3;
		chan _ch3_in = [0] of {int};
		Chandef _ch2;
		chan _ch2_in = [0] of {int};
		Chandef _ch1;
		chan _ch1_in = [0] of {int};
		Chandef _ch0;
		chan _ch0_in = [0] of {int};
		_ch0.in = _ch0_in;
		_ch1.in = _ch1_in;
		_ch2.in = _ch2_in;
		_ch3.in = _ch3_in
	:: true;
	fi;
	_ch4.in = _ch4_in;
	_ch5.in = _ch5_in;
	goto stop_process
stop_process:}

