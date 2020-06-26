
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [inputs] of {int};
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch1_in = [inputs] of {int};
	int i;
	Chandef _ch2;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
		for(i : 1.. inputs) {
for10:		
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
		run Anonymous0(_ch0,_ch1,_ch2)
	};
	do
	:: _ch0.in?0 -> 
		_ch2.closing!true;
		_ch1.closing!true;
		do
		:: _ch1.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				_ch1.in?0;
				

				if
				:: true;
				:: true;
				fi
			fi
		od;
		do
		:: true -> 
for30:
		od;
		break
	:: true -> 
		goto stop_process
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
	do
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		_ch1.in!0;
		_ch1.sending?state;
		_ch0.in!0;
		_ch0.sending?state;
		break
	:: _ch2.in?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od;
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
