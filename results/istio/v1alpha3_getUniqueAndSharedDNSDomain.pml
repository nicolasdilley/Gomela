



init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && min(len(partsFQDN),len())-1 != -1 -> 
				for(i : 0.. min(len(partsFQDN),len())-1) {
for10:			
			if
			:: true -> 
				break
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
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

