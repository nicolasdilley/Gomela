
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [partitionInfos] of {int};
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch1_in = [partitionInfos] of {int};
	int i;
	Chandef _ch2;
	Chandef _ch1;
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
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
		for(i : 0.. concurrent-1) {
for10:		run Anonymous0(_ch0,_ch1,_ch2)
	};
for10_exit:	do
	:: true -> 
for20:		_ch0.in!0;
		_ch0.sending?state
	od;
	_ch0.closing!true;
	do
	:: true -> 
for30:		_ch1.in?0;
		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	goto stop_process;
	_ch2.closing!true
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0;
			do
			:: _ch1.in!0 -> 
				_ch1.sending?state;
				break
			:: _ch2.in?0 -> 
				goto stop_process
			od
		fi
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
