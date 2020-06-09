



init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && levels-1 != -1 -> 
				for(i : 0.. levels-1) {
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					break
				fi
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
					break
				fi
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

