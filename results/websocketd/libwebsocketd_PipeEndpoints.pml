#define lb_for21_0  -1
#define ub_for21_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for21_0 != -1 && ub_for21_1 != -1 -> 
				for(i : lb_for21_0.. ub_for21_1) {
for10:			do
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
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
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
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

