#define lb_for118_0  -1
#define ub_for118_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for118_0 != -1 && ub_for118_1 != -1 -> 
				for(i : lb_for118_0.. ub_for118_1) {
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

