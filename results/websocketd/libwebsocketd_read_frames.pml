#define lb_for67_0  -1
#define ub_for67_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for67_0 != -1 && ub_for67_1 != -1 -> 
				for(i : lb_for67_0.. ub_for67_1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true;
			:: true;
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
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true;
			:: true;
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	we_output.closing!true
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
