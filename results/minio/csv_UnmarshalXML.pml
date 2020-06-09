#define lb_for151_0  -1
#define ub_for151_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for151_0 != -1 && ub_for151_1 != -1 -> 
				for(i : lb_for151_0.. ub_for151_1) {
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
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
					break
				:: true;
				fi;
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

