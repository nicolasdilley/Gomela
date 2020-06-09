#define lb_for149_0  -1
#define ub_for149_1  -1




init { 
	bool state = false;
	int i;
allElems:		
	if
	:: lb_for149_0 != -1 && ub_for149_1 != -1 -> 
				for(i : lb_for149_0.. ub_for149_1) {
for10:			
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
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				goto allElems
			:: true -> 
				goto stop_process
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
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
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				goto allElems
			:: true -> 
				goto stop_process
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:;
	
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
	goto stop_process
stop_process:}

