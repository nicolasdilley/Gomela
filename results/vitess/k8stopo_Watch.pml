
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [10] of {int};
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch2;
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	run go_k8stopocloseOnDone5(_ch2,_ch1,_ch0);
	goto stop_process
stop_process:}

proctype go_k8stopocloseOnDone5(Chandef informerChan;Chandef gracefulShutdown;Chandef changes) {
	bool closed; 
	int i;
	do
	:: true -> 
		
		if
		:: true -> 
			changes.in!0;
			changes.sending?state
		:: true;
		fi;
		break
	:: gracefulShutdown.in?0 -> 
		break
	od;
	informerChan.closing!true;
	changes.closing!true;
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
