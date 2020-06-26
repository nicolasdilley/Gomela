
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_rregisterWithRangefeedRaftMuLocked70 = [0] of {int};
	chan _ch0_in = [1] of {int};
	int i;
	Chandef _ch0;
	
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
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	
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
	run rregisterWithRangefeedRaftMuLocked7(_ch0,child_rregisterWithRangefeedRaftMuLocked70);
	child_rregisterWithRangefeedRaftMuLocked70?0;
	_ch0.in?0;
	goto stop_process
stop_process:}

proctype rregisterWithRangefeedRaftMuLocked7(Chandef errC;chan child) {
	bool closed; 
	int i;
	
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
		do
		:: true -> 
			errC.in!0;
			goto stop_process
		:: true -> 
			break
		od
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
