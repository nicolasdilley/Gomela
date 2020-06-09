#define lb_for122_0  -1
#define ub_for122_1  -1




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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: lb_for122_0 != -1 && ub_for122_1 != -1 -> 
						for(i : lb_for122_0.. ub_for122_1) {
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
					goto stop_process
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	goto stop_process
stop_process:}

