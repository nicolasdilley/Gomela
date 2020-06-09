#define lb_for862_0  -1
#define ub_for862_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for862_0 != -1 && ub_for862_1 != -1 -> 
				for(i : lb_for862_0.. ub_for862_1) {
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
			fi;
			

			if
			:: true -> 
				
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
				fi
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			
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
				fi
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			
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
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

