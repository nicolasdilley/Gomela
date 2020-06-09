



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
	:: true -> 
		goto stop_process
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
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	fi;
	goto stop_process
stop_process:}

