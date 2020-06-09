#define lb_for57_0  -1
#define ub_for57_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for57_0 != -1 && ub_for57_1 != -1 -> 
				for(i : lb_for57_0.. ub_for57_1) {
for10:			do
			:: true -> 
				break
			:: true -> 
				
				if
				:: 0 != -1 && len(it)-1-1 != -1 -> 
										for(i : 0.. len(it)-1-1) {
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
for11_exit:				break
			:: true -> 
				do
				:: true -> 
for12:
				od;
				
				if
				:: 0 != -1 && len()-1-1 != -1 -> 
										for(i : 0.. len()-1-1) {
for13:
					}
				:: else -> 
					do
					:: true -> 
for13:
					:: true -> 
						break
					od
				fi;
for13_exit:				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				break
			:: true -> 
				
				if
				:: 0 != -1 && len(it)-1-1 != -1 -> 
										for(i : 0.. len(it)-1-1) {
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
for11_exit:				break
			:: true -> 
				do
				:: true -> 
for12:
				od;
				
				if
				:: 0 != -1 && len()-1-1 != -1 -> 
										for(i : 0.. len()-1-1) {
for13:
					}
				:: else -> 
					do
					:: true -> 
for13:
					:: true -> 
						break
					od
				fi;
for13_exit:				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

