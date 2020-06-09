#define lb_for188_0  -1
#define ub_for188_1  -1




init { 
	bool state = false;
	int i;
	
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
	
	if
	:: lb_for188_0 != -1 && ub_for188_1 != -1 -> 
				for(i : lb_for188_0.. ub_for188_1) {
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						
						if
						:: true -> 
							break
						:: true -> 
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi;
							goto stop_process
						fi
					fi
				fi;
				
				if
				:: true -> 
					break
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
						
						if
						:: true -> 
							break
						:: true -> 
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi;
							goto stop_process
						fi
					fi
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
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
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:
	od;
	goto stop_process
stop_process:}

