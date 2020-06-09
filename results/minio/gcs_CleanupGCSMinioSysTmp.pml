#define lb_for396_0  -1
#define ub_for396_1  -1
#define lb_for398_2  -1
#define ub_for398_3  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for396_0 != -1 && ub_for396_1 != -1 -> 
				for(i : lb_for396_0.. ub_for396_1) {
for10:			
			if
			:: lb_for398_2 != -1 && ub_for398_3 != -1 -> 
								for(i : lb_for398_2.. ub_for398_3) {
for11:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for11:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for11_exit:
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: lb_for398_2 != -1 && ub_for398_3 != -1 -> 
								for(i : lb_for398_2.. ub_for398_3) {
for11:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for11:					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for11_exit:
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

