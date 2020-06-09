#define lb_for183_0  -1
#define ub_for183_1  -1




init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	do
	:: true -> 
for20:		
		if
		:: lb_for183_0 != -1 && ub_for183_1 != -1 -> 
						for(i : lb_for183_0.. ub_for183_1) {
for21:
			}
		:: else -> 
			do
			:: true -> 
for21:
			:: true -> 
				break
			od
		fi;
for21_exit:
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

