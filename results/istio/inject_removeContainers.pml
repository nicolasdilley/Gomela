



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	
	if
	:: 0 != -1 && len(containers) - 1 != -1 -> 
				for(i : 0.. len(containers) - 1) {
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

