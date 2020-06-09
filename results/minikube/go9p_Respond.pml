#define lb_for402_0  -1
#define ub_for402_1  -1
#define lb_for437_2  -1
#define ub_for437_3  -1




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
		
		if
		:: true -> 
			
			if
			:: lb_for402_0 != -1 && ub_for402_1 != -1 -> 
								for(i : lb_for402_0.. ub_for402_1) {
for10:
				}
			:: else -> 
				do
				:: true -> 
for10:
				:: true -> 
					break
				od
			fi;
for10_exit:
		:: true;
		fi
	fi;
	
	if
	:: lb_for437_2 != -1 && ub_for437_3 != -1 -> 
				for(i : lb_for437_2.. ub_for437_3) {
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
stop_process:}

