#define lb_for72_0  -1
#define ub_for72_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for72_0 != -1 && ub_for72_1 != -1 -> 
				for(i : lb_for72_0.. ub_for72_1) {
for10:			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

