



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
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
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

