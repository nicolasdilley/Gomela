#define lb_for49_0  -1
#define ub_for49_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: lb_for49_0 != -1 && ub_for49_1 != -1 -> 
								for(i : lb_for49_0.. ub_for49_1) {
for10:
				}
			:: else -> 
				do
				:: true -> 
for10:
				:: true -> 
					break
				od
			fi;
for10_exit:
		fi
	fi
stop_process:}

