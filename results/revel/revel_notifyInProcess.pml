



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	
	if
	:: 0 != -1 && w.refreshChannelCount-1 != -1 -> 
				for(i : 0.. w.refreshChannelCount-1) {
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

