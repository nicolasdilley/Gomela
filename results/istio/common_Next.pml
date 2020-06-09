#define lb_for84_0  -1
#define ub_for84_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for84_0 != -1 && ub_for84_1 != -1 -> 
				for(i : lb_for84_0.. ub_for84_1) {
for10:			goto stop_process
		}
	:: else -> 
		do
		:: true -> 
for10:			goto stop_process
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

