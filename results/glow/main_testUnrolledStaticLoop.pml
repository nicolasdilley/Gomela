
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	
	if
	:: 0 != -1 && 7-1 != -1 -> 
				for(i : 0.. 7-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	
	if
	:: 0 != -1 && limit-1 != -1 -> 
				for(i : 0.. limit-1) {
for20:			_ch0.in!0;
			_ch0.sending?state
		}
	:: else -> 
		do
		:: true -> 
for20:			_ch0.in!0;
			_ch0.sending?state
		:: true -> 
			break
		od
	fi;
for20_exit:	_ch0.closing!true
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
