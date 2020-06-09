



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 0 != -1 && n-1 != -1 -> 
				for(i : 0.. n-1) {
for10:			do
			:: true -> 
for11:				
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
							break
						:: true;
						fi
					:: true;
					fi
				:: true;
				fi
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
for11:				
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
							break
						:: true;
						fi
					:: true;
					fi
				:: true;
				fi
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

