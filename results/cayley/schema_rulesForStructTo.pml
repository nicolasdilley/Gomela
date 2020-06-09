



init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && NumField_rt()-1 != -1 -> 
				for(i : 0.. NumField_rt()-1) {
for10:			
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
				fi
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
				
				if
				:: true -> 
					goto stop_process
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				fi
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
for10_exit:	goto stop_process
stop_process:}

