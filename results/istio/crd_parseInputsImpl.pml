#define lb_for148_0  -1
#define ub_for148_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for148_0 != -1 && ub_for148_1 != -1 -> 
				for(i : lb_for148_0.. ub_for148_1) {
for10:			
			if
			:: true -> 
				break
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
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
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
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

