#define lb_for49_0  -1
#define ub_for49_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for49_0 != -1 && ub_for49_1 != -1 -> 
				for(i : lb_for49_0.. ub_for49_1) {
for10:			

			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				goto stop_process
			fi
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
				fi
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				goto stop_process
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

