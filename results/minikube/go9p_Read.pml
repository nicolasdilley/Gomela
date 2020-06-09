



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: 0 != -1 && len(fid.dirs)-1 != -1 -> 
								for(i : 0.. len(fid.dirs)-1) {
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
		:: true;
		fi;
		

		if
		:: true;
		:: true;
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi
stop_process:}

