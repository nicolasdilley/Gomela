
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	run Anonymous0()
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	Chandef _ch0;
	chan _ch0_in = [1] of {int};
	_ch0.in = _ch0_in;
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0;
			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			:: true;
			fi
		fi
	od;
stop_process:
}
