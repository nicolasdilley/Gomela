#define lb_for232_0  -1
#define ub_for232_1  -1
#define lb_for235_2  -1
#define ub_for235_3  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for232_0 != -1 && ub_for232_1 != -1 -> 
				for(i : lb_for232_0.. ub_for232_1) {
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
	:: lb_for235_2 != -1 && ub_for235_3 != -1 -> 
				for(i : lb_for235_2.. ub_for235_3) {
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

