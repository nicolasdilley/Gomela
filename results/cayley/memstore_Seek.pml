#define lb_for536_0  -1
#define ub_for536_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for536_0 != -1 && ub_for536_1 != -1 -> 
				for(i : lb_for536_0.. ub_for536_1) {
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

