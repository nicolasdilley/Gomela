#define lb_for169_0  -1
#define ub_for169_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		
		if
		:: lb_for169_0 != -1 && ub_for169_1 != -1 -> 
						for(i : lb_for169_0.. ub_for169_1) {
for10:				
				if
				:: true -> 
					goto stop_process
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
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:
	fi;
	goto stop_process
stop_process:}

