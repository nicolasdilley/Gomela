#define lb_for38_0  -1
#define ub_for38_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for38_0 != -1 && ub_for38_1 != -1 -> 
				for(i : lb_for38_0.. ub_for38_1) {
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

