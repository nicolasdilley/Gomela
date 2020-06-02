#define lb_for12_0  ??
#define ub_for12_1  ??




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for12_0 != -1 && ub_for12_1 != -1 -> 
				for(i : lb_for12_0.. ub_for12_1+1) {
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

