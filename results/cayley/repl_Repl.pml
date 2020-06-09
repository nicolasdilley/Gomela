#define lb_for117_0  -1
#define ub_for117_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for117_0 != -1 && ub_for117_1 != -1 -> 
				for(i : lb_for117_0.. ub_for117_1) {
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true;
					:: true;
					:: true;
					fi
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				fi
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true;
					:: true;
					:: true;
					fi
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				fi
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

