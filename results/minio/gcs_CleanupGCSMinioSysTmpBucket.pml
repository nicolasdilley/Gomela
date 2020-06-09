#define lb_for371_0  -1
#define ub_for371_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for371_0 != -1 && ub_for371_1 != -1 -> 
				for(i : lb_for371_0.. ub_for371_1) {
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
			:: true;
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
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

