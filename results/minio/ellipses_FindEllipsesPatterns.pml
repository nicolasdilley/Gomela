#define lb_for181_0  -1
#define ub_for181_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for181_0 != -1 && ub_for181_1 != -1 -> 
				for(i : lb_for181_0.. ub_for181_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
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
			break
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	goto stop_process
stop_process:}

