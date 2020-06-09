#define lb_for791_0  -1
#define ub_for791_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for791_0 != -1 && ub_for791_1 != -1 -> 
				for(i : lb_for791_0.. ub_for791_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
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

