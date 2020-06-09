



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true -> 
		
		if
		:: 0 != -1 && NumField_vv()-1 != -1 -> 
						for(i : 0.. NumField_vv()-1) {
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
	:: true -> 
		do
		:: true -> 
for20:
		od
	:: true -> 
		
		if
		:: 0 != -1 && Len_vv()-1 != -1 -> 
						for(i : 0.. Len_vv()-1) {
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

