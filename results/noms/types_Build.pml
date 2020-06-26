#define lb_for138_0  -1
#define ub_for138_1  -1
#define lb_for163_2  -1
#define ub_for163_3  -1
#define lb_for175_4  -1
#define ub_for175_5  -1
#define lb_for187_6  -1
#define ub_for187_7  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [512] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0);
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0;
			
			if
			:: lb_for163_2 != -1 && ub_for163_3 != -1 -> 
								for(i : lb_for163_2.. ub_for163_3) {
for21:
				}
			:: else -> 
				do
				:: true -> 
for21:
				:: true -> 
					break
				od
			fi;
for21_exit:			
			if
			:: lb_for175_4 != -1 && ub_for175_5 != -1 -> 
								for(i : lb_for175_4.. ub_for175_5) {
for22:
				}
			:: else -> 
				do
				:: true -> 
for22:
				:: true -> 
					break
				od
			fi;
for22_exit:
		fi
	od;
	
	if
	:: lb_for187_6 != -1 && ub_for187_7 != -1 -> 
				for(i : lb_for187_6.. ub_for187_7) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: lb_for138_0 != -1 && ub_for138_1 != -1 -> 
				for(i : lb_for138_0.. ub_for138_1) {
for10:			_ch0.in!0;
			_ch0.sending?state
		}
	:: else -> 
		do
		:: true -> 
for10:			_ch0.in!0;
			_ch0.sending?state
		:: true -> 
			break
		od
	fi;
for10_exit:	_ch0.closing!true;
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
