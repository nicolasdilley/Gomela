
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [cfg.clients] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	
	if
	:: 0 != -1 && cfg.clients-1 != -1 -> 
				for(i : 0.. cfg.clients-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	do
	:: true -> 
for20:		run Anonymous0(_ch0)
	od;
	run Anonymous1(_ch0);
	r_Results__.closing!true;
	
	if
	:: true -> 
		do
		:: true -> 
for40:
		od
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for50:
		od
	fi
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0;
			r_Results__.in!0;
			r_Results__.sending?state
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && cfg.limit-1 != -1 -> 
				for(i : 0.. cfg.limit-1) {
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
