#define lb_for210_0  -1
#define ub_for210_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
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
			goto stop_process
		:: true;
		fi;
		
		if
		:: lb_for210_0 != -1 && ub_for210_1 != -1 -> 
						for(i : lb_for210_0.. ub_for210_1) {
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
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				fi;
				goto stop_process
			:: true;
			fi
		:: true;
		fi
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

