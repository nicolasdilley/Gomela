#define lb_for109_0  -1
#define ub_for109_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for109_0 != -1 && ub_for109_1 != -1 -> 
				for(i : lb_for109_0.. ub_for109_1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	pe_output.closing!true
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
