#define lb_for172_0  -1
#define ub_for172_1  -1
#define lb_for194_2  -1
#define ub_for194_3  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for172_0 != -1 && ub_for172_1 != -1 -> 
				for(i : lb_for172_0.. ub_for172_1) {
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: lb_for194_2 != -1 && ub_for194_3 != -1 -> 
										for(i : lb_for194_2.. ub_for194_3) {
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
for11_exit:				do
				:: true -> 
					goto for11_exit
				:: true -> 
					break
				od;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: lb_for194_2 != -1 && ub_for194_3 != -1 -> 
										for(i : lb_for194_2.. ub_for194_3) {
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
for11_exit:				do
				:: true -> 
					goto for11_exit
				:: true -> 
					break
				od;
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

