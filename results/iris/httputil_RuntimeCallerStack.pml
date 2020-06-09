#define lb_for30_0  -1
#define ub_for30_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for30_0 != -1 && ub_for30_1 != -1 -> 
				for(i : lb_for30_0.. ub_for30_1) {
for10:			do
			:: true -> 
for11:
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
for10:			do
			:: true -> 
for11:
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

