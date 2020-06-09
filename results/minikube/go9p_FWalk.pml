#define path  -1
#define lb_for61_1  -1
#define ub_for61_2  -1




init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && len(path)-1 != -1 -> 
				for(i : 0.. len(path)-1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: 0 != -1 && len()-1-1 != -1 -> 
				for(i : 0.. len()-1-1) {
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
	if
	:: lb_for61_1 != -1 && ub_for61_2 != -1 -> 
				for(i : lb_for61_1.. ub_for61_2) {
for30:			
			if
			:: true -> 
				goto error
			:: true;
			fi;
			
			if
			:: true -> 
				goto error
			:: true;
			fi;
			
			if
			:: true -> 
				goto error
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: true -> 
				goto error
			:: true;
			fi;
			
			if
			:: true -> 
				goto error
			:: true;
			fi;
			
			if
			:: true -> 
				goto error
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process;
error:	;
	goto stop_process
stop_process:}

