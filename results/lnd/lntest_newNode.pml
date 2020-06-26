
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan child_nodestart20 = [0] of {int};
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run nodestart2(child_nodestart20);
	child_nodestart20?0;
	
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
	goto stop_process
stop_process:}

proctype nodestart2(chan child) {
	bool closed; 
	int i;
	chan _ch0_in = [0] of {int};
	Chandef _ch0;
	Chandef _ch1;
	chan _ch0_in = [0] of {int};
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	
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
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous1(lndError,_ch0,_ch1,lndError);
	
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
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef lndError;Chandef _ch0;Chandef _ch1;Chandef lndError) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		lndError.in!0;
		lndError.sending?state
	:: true;
	fi;
	_ch1.closing!true;
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
