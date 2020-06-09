



init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && l-1 != -1 -> 
				for(i : 0.. l-1) {
for10:			
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
				
				if
				:: i != -1 && l-1 != -1 -> 
										for(i : i.. l-1) {
for11:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					}
				:: else -> 
					do
					:: true -> 
for11:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true -> 
						break
					od
				fi;
for11_exit:
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: i != -1 && max-1 != -1 -> 
										for(i : i.. max-1) {
for12:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					}
				:: else -> 
					do
					:: true -> 
for12:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true -> 
						break
					od
				fi;
for12_exit:
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
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: i != -1 && l-1 != -1 -> 
										for(i : i.. l-1) {
for11:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					}
				:: else -> 
					do
					:: true -> 
for11:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true -> 
						break
					od
				fi;
for11_exit:
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: i != -1 && max-1 != -1 -> 
										for(i : i.. max-1) {
for12:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					}
				:: else -> 
					do
					:: true -> 
for12:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true -> 
						break
					od
				fi;
for12_exit:
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

