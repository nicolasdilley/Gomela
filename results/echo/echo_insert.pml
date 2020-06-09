#define lb_for112_0  -1
#define ub_for112_1  -1
#define lb_for122_2  -1
#define ub_for122_3  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for112_0 != -1 && ub_for112_1 != -1 -> 
				for(i : lb_for112_0.. ub_for112_1) {
for10:			
			if
			:: lb_for122_2 != -1 && ub_for122_3 != -1 -> 
								for(i : lb_for122_2.. ub_for122_3) {
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
			if
			:: true -> 
				
				if
				:: true -> 
					do
					:: true -> 
for12:
					od
				fi
			fi;
			goto stop_process
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: lb_for122_2 != -1 && ub_for122_3 != -1 -> 
								for(i : lb_for122_2.. ub_for122_3) {
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
			if
			:: true -> 
				
				if
				:: true -> 
					do
					:: true -> 
for12:
					od
				fi
			fi;
			goto stop_process
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

