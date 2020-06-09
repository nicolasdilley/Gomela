



init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && nwname-1 != -1 -> 
				for(i : 0.. nwname-1) {
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 0 != -1 && nwname-1 != -1 -> 
				for(i : 0.. nwname-1) {
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
for20_exit:	goto stop_process
stop_process:}

