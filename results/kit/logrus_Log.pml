#define lb_for45_0  -1
#define ub_for45_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for45_0 != -1 && ub_for45_1 != -1 -> 
				for(i : lb_for45_0.. ub_for45_1) {
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

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	goto stop_process
stop_process:}

