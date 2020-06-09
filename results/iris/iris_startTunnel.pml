#define lb_for621_0  -1
#define ub_for621_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: lb_for621_0 != -1 && ub_for621_1 != -1 -> 
						for(i : lb_for621_0.. ub_for621_1) {
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

