#define lb_for672_0  -1
#define ub_for672_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for672_0 != -1 && ub_for672_1 != -1 -> 
				for(i : lb_for672_0.. ub_for672_1) {
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
for10_exit:	goto stop_process
stop_process:}

