



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
		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	fi;
	goto stop_process
stop_process:}

