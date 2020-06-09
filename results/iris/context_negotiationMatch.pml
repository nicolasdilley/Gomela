



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
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:			
			if
			:: len(accepted) != -1 && n-1-1 != -1 -> 
								for(i : len(accepted).. n-1-1) {
for12:					
					if
					:: true -> 
						break
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
					fi
				}
			:: else -> 
				do
				:: true -> 
for12:					
					if
					:: true -> 
						break
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
					fi
				:: true -> 
					break
				od
			fi;
for12_exit:
		od
	od;
	goto stop_process
stop_process:}

