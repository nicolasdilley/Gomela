#define lb_for689_0  -1
#define ub_for689_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for689_0 != -1 && ub_for689_1 != -1 -> 
				for(i : lb_for689_0.. ub_for689_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
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
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
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

