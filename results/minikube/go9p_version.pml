#define lb_for35_0  -1
#define ub_for35_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: lb_for35_0 != -1 && ub_for35_1 != -1 -> 
						for(i : lb_for35_0.. ub_for35_1) {
for11:
			}
		:: else -> 
			do
			:: true -> 
for11:
			:: true -> 
				break
			od
		fi;
for11_exit:
	od
stop_process:}

