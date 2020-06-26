
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	
	if
	:: true -> 
		chan child_msendSpend30 = [0] of {int};
		run msendSpend3(_ch0,child_msendSpend30);
		child_msendSpend30?0
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype msendSpend3(Chandef channel;chan child) {
	bool closed; 
	int i;
	channel.in!0;
	child!0;
stop_process:
}
