
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [bc.workers] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
		for(i : 0.. bc.workers-1) {
for10:
	};
for10_exit:	do
	:: true -> 
for20:		_ch0.in!0;
		_ch0.sending?state
	od;
	_ch0.closing!true;
	_ch1.closing!true;
	do
	:: _ch1.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch1.in?0;
			
			if
			:: 0 != -1 && partial-1 != -1 -> 
								for(i : 0.. partial-1) {
for31:
				}
			:: else -> 
				do
				:: true -> 
for31:
				:: true -> 
					break
				od
			fi;
for31_exit:
		fi
	od;
	
	if
	:: true -> 
		do
		:: true -> 
for40:
		od
	:: true;
	fi;
	do
	:: true -> 
for50:
	od;
	goto stop_process
stop_process:}

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
