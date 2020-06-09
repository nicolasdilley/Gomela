#define lb_for54_0  -1
#define ub_for54_1  -1
#define lb_for66_2  -1
#define ub_for66_3  -1




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
		
		if
		:: lb_for54_0 != -1 && ub_for54_1 != -1 -> 
						for(i : lb_for54_0.. ub_for54_1) {
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
for10_exit:		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for66_2 != -1 && ub_for66_3 != -1 -> 
				for(i : lb_for66_2.. ub_for66_3) {
for20:			
			if
			:: true -> 
				break
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
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	
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
	goto stop_process
stop_process:}

