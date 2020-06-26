#define backlog  ??

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
		
		if
		:: true -> 
			Chandef _ch0;
			chan _ch0_in = [backlog] of {int};
			_ch0.in = _ch0_in;
			run chanMonitor(_ch0)
		:: true -> 
			Chandef _ch1;
			chan _ch1_in = [backlog] of {int};
			
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
			_ch1.in = _ch1_in;
			run chanMonitor(_ch1);
			_ch1.closing!true;
			do
			:: _ch1.is_closed?state -> 
				if
				:: state -> 
					break
				:: else -> 
					_ch1.in?0;
					_ch1.in!0;
					_ch1.sending?state
				fi
			od
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
		Chandef _ch2;
		chan _ch2_in = [backlog] of {int};
		_ch2.in = _ch2_in;
		run chanMonitor(_ch2)
	:: true;
	fi;
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
