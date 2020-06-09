



init { 
	bool state = false;
	int i;
	

	if
	:: true -> 
		
		if
		:: 0 != -1 && NumField_v()-1 != -1 -> 
						for(i : 0.. NumField_v()-1) {
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
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: 0 != -1 && Len_v()-1 != -1 -> 
						for(i : 0.. Len_v()-1) {
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
for20_exit:		goto stop_process
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

