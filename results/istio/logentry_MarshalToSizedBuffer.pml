



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		od;
		
		if
		:: 0 != -1 && len(keysForMonitoredResourceDimensions) - 1 != -1 -> 
						for(i : 0.. len(keysForMonitoredResourceDimensions) - 1) {
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
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for30:
		od;
		
		if
		:: 0 != -1 && len() - 1 != -1 -> 
						for(i : 0.. len() - 1) {
for40:
			}
		:: else -> 
			do
			:: true -> 
for40:
			:: true -> 
				break
			od
		fi;
for40_exit:
	:: true;
	fi;
	goto stop_process
stop_process:}

