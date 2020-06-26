#define lb_for75_0  -1
#define ub_for75_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	run Anonymous0();
		for(i : lb_for75_0.. ub_for75_1) {
for20:		do
		:: true -> 
			break
		:: true -> 
			resourceLocker.in!0;
			resourceLocker.sending?state;
			break
		od
	};
for20_exit:	resourceLocker.closing!true
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	do
	:: resourceLocker.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			resourceLocker.in?0;
			
			if
			:: true -> 
				do
				:: true -> 
for11:
				od
			:: true;
			fi;
			do
			:: true -> 
for12:
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
