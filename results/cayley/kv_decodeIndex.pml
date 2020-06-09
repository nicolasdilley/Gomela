#define lb_for777_0  -1
#define ub_for777_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for777_0 != -1 && ub_for777_1 != -1 -> 
				for(i : lb_for777_0.. ub_for777_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

