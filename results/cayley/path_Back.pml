#define lb_for494_0  -1
#define ub_for494_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for494_0 != -1 && ub_for494_1 != -1 -> 
				for(i : lb_for494_0.. ub_for494_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: true -> 
for11:					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				od
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
				do
				:: true -> 
for11:					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				od
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

