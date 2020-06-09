#define lb_for1206_0  -1
#define ub_for1206_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
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
	
	if
	:: true -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				break
			:: true;
			fi
		od
	:: true;
	fi;
	
	if
	:: lb_for1206_0 != -1 && ub_for1206_1 != -1 -> 
				for(i : lb_for1206_0.. ub_for1206_1) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

