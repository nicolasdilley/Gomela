
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
		Chandef _ch1;
		chan _ch1_in = [0] of {int};
		Chandef _ch0;
		chan _ch0_in = [0] of {int};
		_ch0.in = _ch0_in;
		run chanMonitor(_ch0);
		_ch1.in = _ch1_in;
		run chanMonitor(_ch1);
		run Anonymous0(_ch0,_ch1);
		chan child_vaultgrabLockOrStop30 = [0] of {int};
		run vaultgrabLockOrStop3(_ch1,child_vaultgrabLockOrStop30);
		child_vaultgrabLockOrStop30?0;
		
		if
		:: true -> 
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od
		:: true;
		fi;
		_ch0.closing!true
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
		break
	:: true -> 
		break
	:: _ch0.in?0 -> 
		break
	od;
	_ch1.closing!true;
stop_process:
}
proctype vaultgrabLockOrStop3(Chandef stopCh;chan child) {
	bool closed; 
	int i;
	Chandef _ch2;
	chan _ch2_in = [0] of {int};
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	run Anonymous2(stopCh,_ch2,stopCh);
	do
	:: stopCh.in?0 -> 
		goto stop_process
	:: _ch2.in?0 -> 
		break
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef stopCh;Chandef _ch2;Chandef stopCh) {
	bool closed; 
	int i;
	do
	:: stopCh.in?0 -> 
		break
	:: true -> 
		_ch2.closing!true;
		break
	od;
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
