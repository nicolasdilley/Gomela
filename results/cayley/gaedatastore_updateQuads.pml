#define lb_for347_0  -1
#define ub_for347_1  -1




init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	
	if
	:: lb_for347_0 != -1 && ub_for347_1 != -1 -> 
				for(i : lb_for347_0.. ub_for347_1) {
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

