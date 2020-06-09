#define lb_for581_0  -1
#define ub_for581_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for581_0 != -1 && ub_for581_1 != -1 -> 
				for(i : lb_for581_0.. ub_for581_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for11:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
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
for11:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

