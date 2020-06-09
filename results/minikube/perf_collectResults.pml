



init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && runs-1 != -1 -> 
				for(i : 0.. runs-1) {
for10:			do
			:: true -> 
for11:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
for11:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

