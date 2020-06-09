#define lb_for85_0  -1
#define ub_for85_1  -1
#define lb_for104_2  -1
#define ub_for104_3  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for85_0 != -1 && ub_for85_1 != -1 -> 
				for(i : lb_for85_0.. ub_for85_1) {
for10:			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
readloop:						
			if
			:: lb_for104_2 != -1 && ub_for104_3 != -1 -> 
								for(i : lb_for104_2.. ub_for104_3) {
for11:					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					

					if
					:: true -> 
						goto readloop
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
						:: true -> 
							goto stop_process
						:: true;
						fi;
						do
						:: true -> 
							goto stop_process
						:: true -> 
							break
						od
					:: true -> 
						goto stop_process
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
						goto readloop
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
						:: true -> 
							goto stop_process
						:: true;
						fi;
						do
						:: true -> 
							goto stop_process
						:: true -> 
							break
						od
					:: true -> 
						goto stop_process
					fi
				:: true -> 
					break
				od
			fi;
for11_exit:;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
readloop:						
			if
			:: lb_for104_2 != -1 && ub_for104_3 != -1 -> 
								for(i : lb_for104_2.. ub_for104_3) {
for11:					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					

					if
					:: true -> 
						goto readloop
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
						:: true -> 
							goto stop_process
						:: true;
						fi;
						do
						:: true -> 
							goto stop_process
						:: true -> 
							break
						od
					:: true -> 
						goto stop_process
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
						goto readloop
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
						:: true -> 
							goto stop_process
						:: true;
						fi;
						do
						:: true -> 
							goto stop_process
						:: true -> 
							break
						od
					:: true -> 
						goto stop_process
					fi
				:: true -> 
					break
				od
			fi;
for11_exit:;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	r_decoded.closing!true
stop_process:}

proctype chanMonitor(Chandef ch) {
	bool closed; 
	int i;
	state = false;
	do
	:: true -> 
		if
		:: state -> 
end:			if
			:: ch.sending!state -> 
				assert(false)
			:: ch.closing?true -> 
				assert(false)
			:: ch.in!0;
			:: ch.is_closed!state;
			fi
		:: else -> 
end1:			if
			:: ch.sending!state;
			:: ch.closing?true -> 
				state = true
			:: ch.is_closed!state;
			fi
		fi
	od;
stop_process:
}
