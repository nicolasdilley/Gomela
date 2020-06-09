#define s  -1
#define lb_for135_1  -1
#define ub_for135_2  -1




init { 
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	:: true;
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for135_1 != -1 && ub_for135_2 != -1 -> 
				for(i : lb_for135_1.. ub_for135_2) {
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
for10_exit:	goto stop_process
stop_process:}

