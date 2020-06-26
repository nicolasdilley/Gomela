
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan child_mainstartEmailCommitLoop10 = [0] of {int};
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch0_in = [0] of {int};
	int i;
	Chandef _ch2;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run mainstartEmailCommitLoop1(_ch0,child_mainstartEmailCommitLoop10);
	child_mainstartEmailCommitLoop10?0;
	_ch2.in = _ch2_in;
	run Anonymous2(_ch0,_ch2);
	do
	:: _ch0.in?0 -> 
		break
	:: _ch2.in?0 -> 
		break
	od
stop_process:}

proctype mainstartEmailCommitLoop1(Chandef errc;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous1(errc,errc);
	child!0;
stop_process:
}
proctype Anonymous1(Chandef errc;Chandef errc) {
	bool closed; 
	int i;
	errc.in!0;
stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch2) {
	bool closed; 
	int i;
	_ch2.in!0;
stop_process:
}
