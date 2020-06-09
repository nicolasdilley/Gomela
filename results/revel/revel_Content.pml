#define lb_for467_0  -1
#define ub_for467_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		
		if
		:: lb_for467_0 != -1 && ub_for467_1 != -1 -> 
						for(i : lb_for467_0.. ub_for467_1) {
for10:
			}
		:: else -> 
			do
			:: true -> 
for10:
			:: true -> 
				break
			od
		fi;
for10_exit:
	:: true;
	fi;
	goto stop_process
stop_process:}

