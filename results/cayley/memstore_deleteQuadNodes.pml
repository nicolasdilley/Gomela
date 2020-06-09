



init { 
	bool state = false;
	int i;
	
	if
	:: quad.Subject != -1 && quad.Label != -1 -> 
				for(i : quad.Subject.. quad.Label) {
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
stop_process:}

