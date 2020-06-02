#define lb_for15_0  ??
#define ub_for15_1  ??




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for15_0 != -1 && ub_for15_1 != -1 -> 
				for(i : lb_for15_0.. ub_for15_1+1) {
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
stop_process:}

