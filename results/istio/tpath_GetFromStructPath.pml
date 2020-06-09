



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
	

	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 0 != -1 && NumField_structElems()-1 != -1 -> 
				for(i : 0.. NumField_structElems()-1) {
for10:			goto stop_process
		}
	:: else -> 
		do
		:: true -> 
for10:			goto stop_process
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

