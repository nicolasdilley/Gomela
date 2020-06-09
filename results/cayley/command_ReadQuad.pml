#define lb_for47_0  -1
#define ub_for47_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for47_0 != -1 && ub_for47_1 != -1 -> 
				for(i : lb_for47_0.. ub_for47_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
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
			goto stop_process
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

