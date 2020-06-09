



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	
	if
	:: true -> 
		
		if
		:: 0 != -1 && l.Multiplier-1 != -1 -> 
						for(i : 0.. l.Multiplier-1) {
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
		
		if
		:: 0 != -1 && len(requests) - 1-1 != -1 -> 
						for(i : 0.. len(requests) - 1-1) {
for30:
			}
		:: else -> 
			do
			:: true -> 
for30:
			:: true -> 
				break
			od
		fi;
for30_exit:
	:: true;
	fi;
	goto stop_process
stop_process:}

