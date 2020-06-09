#define lb_for229_0  -1
#define ub_for229_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for229_0 != -1 && ub_for229_1 != -1 -> 
				for(i : lb_for229_0.. ub_for229_1) {
for10:			do
			:: true -> 
				
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
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				break
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				
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
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				break
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

