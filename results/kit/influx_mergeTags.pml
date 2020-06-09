#define lb_for182_0  -1
#define ub_for182_1  -1




init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	
	if
	:: lb_for182_0 != -1 && ub_for182_1 != -1 -> 
				for(i : lb_for182_0.. ub_for182_1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

