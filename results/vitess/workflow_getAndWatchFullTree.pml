
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_m_NodeManager__GetAndWatchFullTree10 = [0] of {int};
	chan _ch0_in = [10] of {int};
	int i;
	Chandef _ch0;
	
	if
	:: true -> 
		
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
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run m_NodeManager__GetAndWatchFullTree1(_ch0,child_m_NodeManager__GetAndWatchFullTree10);
	child_m_NodeManager__GetAndWatchFullTree10?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype m_NodeManager__GetAndWatchFullTree1(Chandef notifications;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
