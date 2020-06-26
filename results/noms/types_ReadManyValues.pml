
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	od;
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [16] of {int};
		_ch0.in = _ch0_in;
		run chanMonitor(_ch0);
		run Anonymous0(_ch0);
		do
		:: _ch0.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				_ch0.in?0
			fi
		od
	:: true;
	fi;
	do
	:: true -> 
for30:
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
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
