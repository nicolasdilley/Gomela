#define lb_for363_0  -1
#define ub_for363_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for363_0 != -1 && ub_for363_1 != -1 -> 
				for(i : lb_for363_0.. ub_for363_1) {
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	con_requestC.closing!true
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
