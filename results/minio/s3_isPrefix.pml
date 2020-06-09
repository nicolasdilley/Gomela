#define lb_for189_0  -1
#define ub_for189_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for189_0 != -1 && ub_for189_1 != -1 -> 
				for(i : lb_for189_0.. ub_for189_1) {
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
			od;
			
			if
			:: true -> 
				break
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
			fi;
			do
			:: true -> 
for11:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			od;
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

