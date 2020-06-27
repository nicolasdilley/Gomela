
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
		chan child_dbcompTriggerWait10 = [0] of {int};
		run dbcompTriggerWait1(child_dbcompTriggerWait10);
		child_dbcompTriggerWait10?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype dbcompTriggerWait1(chan child) {
	bool closed; 
	int i;
	Chandef _ch0;
	chan _ch0_in = [0] of {int};
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	do
	:: compC.in!0 -> 
		compC.sending?state;
		break
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	do
	:: _ch0.in?0 -> 
		break
	:: true -> 
		break
	:: true -> 
		goto stop_process
	od;
	goto stop_process;
	_ch0.closing!true;
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
