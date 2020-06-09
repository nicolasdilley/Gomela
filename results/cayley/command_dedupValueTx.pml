#define lb_for186_0  -1
#define ub_for186_1  -1
#define lb_for200_2  -1
#define ub_for200_3  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for186_0 != -1 && ub_for186_1 != -1 -> 
				for(i : lb_for186_0.. ub_for186_1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for200_2 != -1 && ub_for200_3 != -1 -> 
				for(i : lb_for200_2.. ub_for200_3) {
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
for20_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

