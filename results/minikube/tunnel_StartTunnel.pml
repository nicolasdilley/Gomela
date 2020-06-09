
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	chan _ch2_in = [1] of {int};
	bool state = false;
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch2;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	_ch2.in = _ch2_in;
	goto stop_process
stop_process:}

