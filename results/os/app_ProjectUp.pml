
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
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef _ch2;
		chan _ch2_in = [0] of {int};
		Chandef _ch1;
		chan _ch1_in = [0] of {int};
		Chandef _ch0;
		chan _ch0_in = [1] of {int};
		_ch0.in = _ch0_in;
		_ch1.in = _ch1_in;
		_ch2.in = _ch2_in;
		run Anonymous0(_ch0,_ch1,_ch2);
		run Anonymous1(_ch0,_ch1,_ch2);
		_ch1.in?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
	_ch2.in!0;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
	do
	:: _ch0.in?0 -> 
		_ch1.in!0;
		break
	:: _ch2.in?0 -> 
		_ch1.in!0;
		break
	od;
stop_process:
}
