
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
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [len(response.reply.Rows) + 1] of {int};
		_ch0.in = _ch0_in;
		run chanMonitor(_ch0);
		_ch0.in!0;
		_ch0.sending?state;
		do
		:: true -> 
for10:			_ch0.in!0;
			_ch0.sending?state
		od
	:: true -> 
		Chandef _ch1;
		chan _ch1_in = [0] of {int};
		_ch1.in = _ch1_in;
		run chanMonitor(_ch1)
	fi;
	goto stop_process;
	resultChan.closing!true
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
