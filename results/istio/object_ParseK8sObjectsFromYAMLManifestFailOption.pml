#define lb_for242_0  -1
#define ub_for242_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for242_0 != -1 && ub_for242_1 != -1 -> 
				for(i : lb_for242_0.. ub_for242_1) {
for10:			
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
				fi
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
				fi;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	od;
	goto stop_process
stop_process:}

