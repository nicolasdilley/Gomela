#define lb_for87_0  -1
#define ub_for87_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for87_0 != -1 && ub_for87_1 != -1 -> 
				for(i : lb_for87_0.. ub_for87_1) {
for10:			
			if
			:: true -> 
				goto stop_process
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
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

