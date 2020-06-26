#define lb_for159_0  -1
#define ub_for159_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [128] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
		for(i : 1.. headers) {
for10:
	};
	do
	:: true -> 
for20:		
		if
		:: true -> 
			_ch0.closing!true;
			break
		fi;
		do
		:: true -> 
for21:			_ch.in!0;
			_ch.sending?state
		od
	od;
for20_exit:		for(i : 1.. cols) {
for30:		col_ch.closing!true
	};
	goto stop_process
stop_process:}

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
