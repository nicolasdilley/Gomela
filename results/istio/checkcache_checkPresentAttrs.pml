#define lb_for134_0  -1
#define ub_for134_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && len(ks.presentAttrs)-1 != -1 -> 
				for(i : 0.. len(ks.presentAttrs)-1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: lb_for134_0 != -1 && ub_for134_1 != -1 -> 
								for(i : lb_for134_0.. ub_for134_1) {
for11:					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					
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
						goto stop_process
					:: true;
					fi;
					
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
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: lb_for134_0 != -1 && ub_for134_1 != -1 -> 
								for(i : lb_for134_0.. ub_for134_1) {
for11:					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					
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
						goto stop_process
					:: true;
					fi;
					
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
for10_exit:	goto stop_process
stop_process:}

