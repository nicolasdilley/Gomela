#define lb_for577_0  -1
#define ub_for577_1  -1

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
	do
	:: true -> 
		break
	:: _ch0.in?0 -> 
		goto stop_process
	od
stop_process:}

proctype sGracefulDown2(Chandef done;chan child) {
	bool closed; 
	int i;
	
	if
	:: lb_for577_0 != -1 && ub_for577_1 != -1 -> 
				for(i : lb_for577_0.. ub_for577_1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi;
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
for10:			
			if
			:: true -> 
				break
			:: true;
			fi;
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
for10_exit:	done.closing!true;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_sGracefulDown20 = [0] of {int};
	run sGracefulDown2(_ch0,child_sGracefulDown20);
	child_sGracefulDown20?0;
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
