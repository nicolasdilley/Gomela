
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [watchStreams] of {int};
	chan _ch1_in = [streams] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	do
	:: true -> 
for10:
	od;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	do
	:: true -> 
for20:		run Anonymous0(_ch0,_ch1)
	od;
	run Anonymous1(_ch0,_ch1);
	r_Results__.closing!true;
	
	if
	:: 0 != -1 && streams-1 != -1 -> 
				for(i : 0.. streams-1) {
for40:
		}
	:: else -> 
		do
		:: true -> 
for40:
		:: true -> 
			break
		od
	fi;
for40_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && watchWatchesPerStream-1 != -1 -> 
				for(i : 0.. watchWatchesPerStream-1) {
for21:			_ch0.in?0;
			rch.in!0;
			rch.sending?state
		}
	:: else -> 
		do
		:: true -> 
for21:			_ch0.in?0;
			rch.in!0;
			rch.sending?state
		:: true -> 
			break
		od
	fi;
for21_exit:	_ch1.in!0;
	_ch1.sending?state;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && watchStreams * watchWatchesPerStream-1 != -1 -> 
				for(i : 0.. watchStreams * watchWatchesPerStream-1) {
for30:			_ch0.in!0;
			_ch0.sending?state
		}
	:: else -> 
		do
		:: true -> 
for30:			_ch0.in!0;
			_ch0.sending?state
		:: true -> 
			break
		od
	fi;
for30_exit:	_ch0.closing!true;
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
