#define lb_for46_0  -1
#define ub_for46_1  -1
#define lb_for57_2  -1
#define ub_for57_3  -1




init { 
	bool state = false;
	int i;
loop:		
	if
	:: lb_for46_0 != -1 && ub_for46_1 != -1 -> 
				for(i : lb_for46_0.. ub_for46_1) {
for10:			do
			:: true -> 
				goto loop;
				break
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: lb_for57_2 != -1 && ub_for57_3 != -1 -> 
										for(i : lb_for57_2.. ub_for57_3) {
for11:						do
						:: true -> 
							goto loop;
							break
						:: true -> 
							
							if
							:: true -> 
								break
							:: true;
							fi;
							break
						:: true -> 
							break
						od
					}
				:: else -> 
					do
					:: true -> 
for11:						do
						:: true -> 
							goto loop;
							break
						:: true -> 
							
							if
							:: true -> 
								break
							:: true;
							fi;
							break
						:: true -> 
							break
						od
					:: true -> 
						break
					od
				fi;
for11_exit:				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				goto loop;
				break
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: lb_for57_2 != -1 && ub_for57_3 != -1 -> 
										for(i : lb_for57_2.. ub_for57_3) {
for11:						do
						:: true -> 
							goto loop;
							break
						:: true -> 
							
							if
							:: true -> 
								break
							:: true;
							fi;
							break
						:: true -> 
							break
						od
					}
				:: else -> 
					do
					:: true -> 
for11:						do
						:: true -> 
							goto loop;
							break
						:: true -> 
							
							if
							:: true -> 
								break
							:: true;
							fi;
							break
						:: true -> 
							break
						od
					:: true -> 
						break
					od
				fi;
for11_exit:				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:;
	q_chout.closing!true
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
