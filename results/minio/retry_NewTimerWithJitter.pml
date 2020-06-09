#define lb_for100_0  -1
#define ub_for100_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: lb_for100_0 != -1 && ub_for100_1 != -1 -> 
				for(i : lb_for100_0.. ub_for100_1) {
for10:			do
			:: _ch0.in!0 -> 
				_ch0.sending?state;
				break
			:: true -> 
				goto stop_process
			od;
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: _ch0.in!0 -> 
				_ch0.sending?state;
				break
			:: true -> 
				goto stop_process
			od;
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od
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
