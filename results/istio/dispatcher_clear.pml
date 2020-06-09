#define lb_for89_0  -1
#define ub_for89_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for89_0 != -1 && ub_for89_1 != -1 -> 
				for(i : lb_for89_0.. ub_for89_1) {
for10:			do
			:: true -> 
				break
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
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

