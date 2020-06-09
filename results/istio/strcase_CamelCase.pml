#define s  -1
#define lb_for38_1  -1
#define ub_for38_2  -1
#define lb_for55_3  -1
#define ub_for55_4  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for38_1 != -1 && ub_for38_2 != -1 -> 
				for(i : lb_for38_1.. ub_for38_2) {
for10:			
			if
			:: lb_for55_3 != -1 && ub_for55_4 != -1 -> 
								for(i : lb_for55_3.. ub_for55_4) {
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
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: lb_for55_3 != -1 && ub_for55_4 != -1 -> 
								for(i : lb_for55_3.. ub_for55_4) {
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
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

