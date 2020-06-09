#define lb_for129_0  -1
#define ub_for129_1  -1
#define lb_for138_2  -1
#define ub_for138_3  -1




init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: lb_for129_0 != -1 && ub_for129_1 != -1 -> 
								for(i : lb_for129_0.. ub_for129_1) {
for11:
				}
			:: else -> 
				do
				:: true -> 
for11:
				:: true -> 
					break
				od
			fi;
for11_exit:
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: lb_for138_2 != -1 && ub_for138_3 != -1 -> 
								for(i : lb_for138_2.. ub_for138_3) {
for12:
				}
			:: else -> 
				do
				:: true -> 
for12:
				:: true -> 
					break
				od
			fi;
for12_exit:
		fi
	od;
	goto stop_process
stop_process:}

