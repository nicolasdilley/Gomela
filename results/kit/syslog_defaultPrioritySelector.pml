#define lb_for125_0  -1
#define ub_for125_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for125_0 != -1 && ub_for125_1 != -1 -> 
				for(i : lb_for125_0.. ub_for125_1) {
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					fi
				:: true;
				fi
			:: true;
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
					

					if
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					fi
				:: true;
				fi
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

