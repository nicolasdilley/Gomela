



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
			if
			:: true -> 
				break
			:: true -> 
				
				if
				:: true -> 
					break
				fi
			fi
		od
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				fi
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
for20:
		od;
		do
		:: true -> 
for30:
		od;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

