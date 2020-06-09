



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
		do
		:: true -> 
for10:
		od;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 0 != -1 && NumField_typ()-1 != -1 -> 
				for(i : 0.. NumField_typ()-1) {
for20:			
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
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: true -> 
for21:					
					if
					:: true -> 
						break
					:: true;
					fi
				od
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
				
				if
				:: 0 != -1 && numElems-1 != -1 -> 
										for(i : 0.. numElems-1) {
for22:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					}
				:: else -> 
					do
					:: true -> 
for22:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true -> 
						break
					od
				fi;
for22_exit:
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
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
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: true -> 
for21:					
					if
					:: true -> 
						break
					:: true;
					fi
				od
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
				
				if
				:: 0 != -1 && numElems-1 != -1 -> 
										for(i : 0.. numElems-1) {
for22:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					}
				:: else -> 
					do
					:: true -> 
for22:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true -> 
						break
					od
				fi;
for22_exit:
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

