#define lb_for188_0  -1
#define ub_for188_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for188_0 != -1 && ub_for188_1 != -1 -> 
				for(i : lb_for188_0.. ub_for188_1) {
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
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
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
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
for10_exit:
stop_process:}

