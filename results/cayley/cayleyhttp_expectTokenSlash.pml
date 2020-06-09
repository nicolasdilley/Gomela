#define s  -1
#define lb_for107_1  -1
#define ub_for107_2  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for107_1 != -1 && ub_for107_2 != -1 -> 
				for(i : lb_for107_1.. ub_for107_2) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

