



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		
		if
		:: 0 != -1 && len(d.appliedFiles) - 1 != -1 -> 
						for(i : 0.. len(d.appliedFiles) - 1) {
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
	fi;
	goto stop_process
stop_process:}

