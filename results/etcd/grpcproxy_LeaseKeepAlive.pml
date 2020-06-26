
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [2] of {int};
	chan _ch1_in = [3] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	do
	:: true -> 
		goto stop_process
	:: true -> 
		break
	od;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	
	if
	:: true -> 
		
		if
		:: true -> 
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od
		:: true;
		fi
	:: true;
	fi;
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous0(_ch0,_ch1);
	run Anonymous1(_ch0,_ch1);
	run Anonymous2(_ch0,_ch1);
	do
	:: _ch1.in?0 -> 
		_ch1.in!0;
		_ch1.sending?state;
		break
	:: _ch0.in?0 -> 
		break
	od;
	run Anonymous3(_ch0,_ch1);
	do
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	od
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		_ch0.in!0;
		_ch0.sending?state
	:: true;
	fi;
	_ch1.in!0;
	_ch1.sending?state;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		_ch0.in!0;
		_ch0.sending?state
	:: true;
	fi;
	_ch1.in!0;
	_ch1.sending?state;
stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
		break
	:: true -> 
		break
	:: true -> 
		break
	od;
	_ch1.in!0;
	_ch1.sending?state;
stop_process:
}
proctype Anonymous3(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	_ch1.in?0;
	_ch1.in?0;
	_ch1.in?0;
	_ch0.closing!true;
stop_process:
}
proctype chanMonitor(Chandef ch) {
	bool closed; 
	int i;
	state = false;
	do
	:: true -> 
		if
		:: state -> 
end:			if
			:: ch.sending!state -> 
				assert(false)
			:: ch.closing?true -> 
				assert(false)
			:: ch.in!0;
			:: ch.is_closed!state;
			fi
		:: else -> 
end1:			if
			:: ch.sending!state;
			:: ch.closing?true -> 
				state = true
			:: ch.is_closed!state;
			fi
		fi
	od;
stop_process:
}
