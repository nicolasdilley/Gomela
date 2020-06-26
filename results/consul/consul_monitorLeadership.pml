#define lb_for66_0  -1
#define ub_for66_1  -1
#define lb_for230_2  -1
#define ub_for230_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
		for(i : lb_for66_0.. ub_for66_1) {
for10:		do
		:: true -> 
			

			if
			:: true -> 
				run Anonymous0(weAreLeaderCh)
			:: true -> 
				weAreLeaderCh.closing!true
			fi;
			break
		:: true -> 
			break
		:: true -> 
			goto stop_process
		od
	};
for10_exit:
stop_process:}

proctype sleaderLoop1(Chandef stopCh;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:
	od;
RECONCILE:	;
	
	if
	:: true -> 
		goto WAIT
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto WAIT
			:: true;
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto WAIT
	:: true;
	fi;
WAIT:		do
	:: true -> 
		goto stop_process
	:: true -> 
		break
	od;
		for(i : lb_for230_2.. ub_for230_3) {
for12:		do
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: true -> 
			goto RECONCILE;
			break
		:: true -> 
			break
		:: true -> 
			break
		:: true -> 
			
			if
			:: true -> 
				errCh.in!0;
				errCh.sending?state
			:: true;
			fi;
			errCh.in!0;
			errCh.sending?state;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto WAIT
				:: true;
				fi;
				goto stop_process
			:: true;
			fi;
			break
		od
	};
for12_exit:	child!0;
stop_process:
}
proctype Anonymous0(Chandef weAreLeaderCh) {
	bool closed; 
	int i;
	chan child_sleaderLoop10 = [0] of {int};
	run sleaderLoop1(weAreLeaderCh,child_sleaderLoop10);
	child_sleaderLoop10?0;
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
