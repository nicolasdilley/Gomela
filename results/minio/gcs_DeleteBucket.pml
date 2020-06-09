#define lb_for491_0  -1
#define ub_for491_1  -1
#define lb_for514_2  -1
#define ub_for514_3  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for491_0 != -1 && ub_for491_1 != -1 -> 
				for(i : lb_for491_0.. ub_for491_1) {
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
			break
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
			break
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: lb_for514_2 != -1 && ub_for514_3 != -1 -> 
						for(i : lb_for514_2.. ub_for514_3) {
for20:				
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
				fi
			}
		:: else -> 
			do
			:: true -> 
for20:				
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
				fi
			:: true -> 
				break
			od
		fi;
for20_exit:
	:: true;
	fi;
	goto stop_process
stop_process:}

