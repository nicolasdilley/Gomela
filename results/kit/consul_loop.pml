#define lb_for69_0  -1
#define ub_for69_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for69_0 != -1 && ub_for69_1 != -1 -> 
				for(i : lb_for69_0.. ub_for69_1) {
for10:			

			if
			:: true -> 
				goto stop_process
			:: true;
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			

			if
			:: true -> 
				goto stop_process
			:: true;
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

