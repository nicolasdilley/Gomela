
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [1] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run Anonymous0(_ch0,c);
	do
	:: true -> 
		run Anonymous1(_ch0,c);
		goto stop_process
	:: _ch0.in?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	od;
	_ch1.in = _ch1_in;
	run Anonymous2(_ch0,_ch1);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef c) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef c) {
	bool closed; 
	int i;
	_ch0.in?0;
stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
		break
	:: _ch1.in?0 -> 
		break
	od;
stop_process:
}
