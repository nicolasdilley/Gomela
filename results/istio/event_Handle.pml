#define lb_for110_0  -1
#define ub_for110_1  -1




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
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: lb_for110_0 != -1 && ub_for110_1 != -1 -> 
						for(i : lb_for110_0.. ub_for110_1) {
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
for10_exit:		goto stop_process
	:: true;
	fi
stop_process:}

