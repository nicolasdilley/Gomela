#define lb_for231_0  -1
#define ub_for231_1  -1
#define lb_for295_2  -1
#define ub_for295_3  -1




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
	:: true -> 
		goto stop_process
	:: true -> 
		
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
			fi;
			
			if
			:: lb_for231_0 != -1 && ub_for231_1 != -1 -> 
								for(i : lb_for231_0.. ub_for231_1) {
for10:					
					if
					:: true -> 
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
						goto stop_process
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for10_exit:			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true;
			:: true;
			:: true;
			fi;
			goto stop_process
		:: true;
		fi;
		goto stop_process
	fi;
	
	if
	:: true -> 
		
		if
		:: lb_for295_2 != -1 && ub_for295_3 != -1 -> 
						for(i : lb_for295_2.. ub_for295_3) {
for20:				

				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true -> 
					goto stop_process
				fi
			}
		:: else -> 
			do
			:: true -> 
for20:				

				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true -> 
					goto stop_process
				fi
			:: true -> 
				break
			od
		fi;
for20_exit:		goto stop_process
	:: true;
	fi
stop_process:}

