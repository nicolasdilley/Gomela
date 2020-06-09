#define lb_for632_0  -1
#define ub_for632_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: lb_for632_0 != -1 && ub_for632_1 != -1 -> 
						for(i : lb_for632_0.. ub_for632_1) {
for10:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				
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
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:
	:: true;
	fi;
	goto stop_process
stop_process:}

