
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch4_in = [8] of {int};
	chan _ch0_in = [8] of {int};
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch3_in = [1000] of {int};
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch4;
	Chandef _ch3;
	Chandef _ch2;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	run Anonymous0(_ch0,_ch1,_ch2,workch,resch);
	_ch3.in = _ch3_in;
	run chanMonitor(_ch3);
	_ch4.in = _ch4_in;
	run chanMonitor(_ch4);
FeedWork:		do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0;
			do
			:: _ch3.in!0 -> 
				_ch3.sending?state;
				break
			:: true -> 
				goto FeedWork;
				break
			od
		fi
	od;
	_ch3.closing!true;
	
	if
	:: 0 != -1 && toCopy-1 != -1 -> 
				for(i : 0.. toCopy-1) {
for20:			_ch4.in?0
		}
	:: else -> 
		do
		:: true -> 
for20:			_ch4.in?0
		:: true -> 
			break
		od
	fi;
for20_exit:	_ch1.in?0;
	goto stop_process;
	_ch2.closing!true
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef workch;Chandef resch) {
	bool closed; 
	int i;
	_ch1.in!0;
	_ch1.sending?state;
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
