#define lb_for237_0  ??
#define ub_for237_1  ??




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for237_0 != -1 && ub_for237_1 != -1 -> 
				for(i : lb_for237_0.. ub_for237_1+1) {
for10:			do
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

