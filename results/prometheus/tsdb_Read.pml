#define lb_for914_0  -1
#define ub_for914_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [100] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous0(_ch0,_ch1);
	
	if
	:: lb_for914_0 != -1 && ub_for914_1 != -1 -> 
				for(i : lb_for914_0.. ub_for914_1) {
for20:			

			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				datac.in!0;
				datac.sending?state;
				do
				:: true -> 
for21:
				od
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				datac.in!0;
				datac.sending?state;
				do
				:: true -> 
for22:
				od
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				datac.in!0;
				datac.sending?state;
				do
				:: true -> 
for23:					do
					:: true -> 
for24:
					od
				od
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			

			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				datac.in!0;
				datac.sending?state;
				do
				:: true -> 
for21:
				od
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				datac.in!0;
				datac.sending?state;
				do
				:: true -> 
for22:
				od
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				datac.in!0;
				datac.sending?state;
				do
				:: true -> 
for23:					do
					:: true -> 
for24:
					od
				od
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	_ch1.closing!true;
	_ch0.in?0;
	
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
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: _ch1.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch1.in?0
		fi
	od;
	_ch0.closing!true;
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
