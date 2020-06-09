



init { 
	bool state = false;
	int i;
	
	if
	:: quad.Subject != -1 && quad.Label != -1 -> 
				for(i : quad.Subject.. quad.Label) {
for10:			
			if
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
for10:			
			if
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
for10_exit:	goto stop_process
stop_process:}

