
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_dbcompTrigger10 = [0] of {int};
	chan _ch0_in = [0] of {int};
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
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	do
	:: db_tcompPauseC.in!0 -> 
		db_tcompPauseC.sending?state;
		break
	:: true -> 
		_ch0.closing!true;
		break
	:: true -> 
		break
	od;
	do
	:: true -> 
for10:
	od;
	
	if
	:: true -> 
		do
		:: _ch0.in?0 -> 
			_ch0.closing!true;
			break
		:: true -> 
			break
		od
	:: true;
	fi;
	run dbcompTrigger1(child_dbcompTrigger10);
	child_dbcompTrigger10?0
stop_process:}

proctype dbcompTrigger1(chan child) {
	bool closed; 
	int i;
	do
	:: compC.in!0 -> 
		compC.sending?state;
		break
	:: true -> 
		break
	od;
	child!0;
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
