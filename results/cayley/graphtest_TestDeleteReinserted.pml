



init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && 2-1 != -1 -> 
				for(i : 0.. 2-1) {
for10:			do
			:: true -> 
for11:
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
for11:
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

