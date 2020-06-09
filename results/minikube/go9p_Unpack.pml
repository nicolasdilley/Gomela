



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
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto szerror
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto szerror
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto szerror
		:: true;
		fi;
		
		if
		:: true -> 
			goto szerror
		:: true;
		fi
	:: true;
	:: true;
	:: true -> 
		
		if
		:: true -> 
			goto szerror
		:: true;
		fi;
		
		if
		:: true -> 
			goto szerror
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto szerror
		:: true;
		fi
	:: true -> 
		
		if
		:: 0 != -1 && int(m)-1 != -1 -> 
						for(i : 0.. int(m)-1) {
for10:				
				if
				:: true -> 
					goto szerror
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for10:				
				if
				:: true -> 
					goto szerror
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:
	:: true -> 
		
		if
		:: 0 != -1 && int()-1 != -1 -> 
						for(i : 0.. int()-1) {
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
	:: true;
	:: true -> 
		
		if
		:: true -> 
			goto szerror
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto szerror
			:: true;
			fi
		:: true;
		fi
	:: true;
	:: true -> 
		
		if
		:: true -> 
			goto szerror
		:: true;
		fi
	:: true;
	:: true;
	:: true;
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	:: true;
	fi;
	
	if
	:: true -> 
		goto szerror
	:: true;
	fi;
	goto stop_process;
szerror:		goto stop_process
stop_process:}

