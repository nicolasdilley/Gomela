



init { 
	bool state = false;
	int i;
	
	if
	:: Black != -1 && DarkGray-1 != -1 -> 
				for(i : Black.. DarkGray-1) {
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
	:: DarkGray != -1 && numColors-1 != -1 -> 
				for(i : DarkGray.. numColors-1) {
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
stop_process:}

