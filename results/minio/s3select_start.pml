#define lb_for290_0  -1
#define ub_for290_1  -1
#define lb_for316_2  -1
#define ub_for316_3  -1
#define lb_for361_4  -1
#define ub_for361_5  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for290_0 != -1 && ub_for290_1 != -1 -> 
				for(i : lb_for290_0.. ub_for290_1) {
for10:			do
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				break
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi;
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					
					if
					:: lb_for316_2 != -1 && ub_for316_3 != -1 -> 
												for(i : lb_for316_2.. ub_for316_3) {
for11:							
							if
							:: true -> 
								
								if
								:: true -> 
									break
								:: true;
								fi
							:: true;
							fi
						}
					:: else -> 
						do
						:: true -> 
for11:							
							if
							:: true -> 
								
								if
								:: true -> 
									break
								:: true;
								fi
							:: true;
							fi
						:: true -> 
							break
						od
					fi;
for11_exit:
				fi;
				break
			:: true -> 
				break
			:: true -> 
				break
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				break
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi;
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					
					if
					:: lb_for316_2 != -1 && ub_for316_3 != -1 -> 
												for(i : lb_for316_2.. ub_for316_3) {
for11:							
							if
							:: true -> 
								
								if
								:: true -> 
									break
								:: true;
								fi
							:: true;
							fi
						}
					:: else -> 
						do
						:: true -> 
for11:							
							if
							:: true -> 
								
								if
								:: true -> 
									break
								:: true;
								fi
							:: true;
							fi
						:: true -> 
							break
						od
					fi;
for11_exit:
				fi;
				break
			:: true -> 
				break
			:: true -> 
				break
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	writer_doneCh.closing!true;
	
	if
	:: lb_for361_4 != -1 && ub_for361_5 != -1 -> 
				for(i : lb_for361_4.. ub_for361_5) {
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
