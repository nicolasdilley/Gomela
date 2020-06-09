#define lb_for255_0  -1
#define ub_for255_1  -1




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
		:: lb_for255_0 != -1 && ub_for255_1 != -1 -> 
						for(i : lb_for255_0.. ub_for255_1) {
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
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

