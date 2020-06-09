



init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && n-1 != -1 -> 
				for(i : 0.. n-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: 0 != -1 && n-1 != -1 -> 
				for(i : 0.. n-1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process
stop_process:}

