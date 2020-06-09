



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
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
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				od;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

