#define lb_for866_0  -1
#define ub_for866_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	int i;
	chan child_routingNewValidationBarrier20 = [0] of {int};
	bool state = false;
	run routingNewValidationBarrier2(child_routingNewValidationBarrier20);
	child_routingNewValidationBarrier20?0;
		for(i : lb_for866_0.. ub_for866_1) {
for20:		do
		:: true -> 
			run Anonymous1();
			break
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for21:				do
				:: true -> 
for22:
				od
			od;
			break
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					client_exit.closing!true;
					client_ntfnChan.closing!true
				:: true;
				fi
			:: true;
			fi;
			break
		:: true -> 
			break
		:: true -> 
			break
		:: true -> 
			goto stop_process
		od
	};
for20_exit:
stop_process:}

proctype routingNewValidationBarrier2(chan child) {
	bool closed; 
	int i;
	Chandef _ch0;
	chan _ch0_in = [numActiveReqs _1] of {int};
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	
	if
	:: 0 != -1 && numActiveReqs _1-1 != -1 -> 
				for(i : 0.. numActiveReqs _1-1) {
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
for10_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	update_err.in!0;
	update_err.sending?state;
	
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
