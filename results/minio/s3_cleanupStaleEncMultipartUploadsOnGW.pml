#define lb_for711_0  -1
#define ub_for711_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for711_0 != -1 && ub_for711_1 != -1 -> 
				for(i : lb_for711_0.. ub_for711_1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi;
			do
			:: true -> 
for11:				do
				:: true -> 
for12:
				od
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi;
			do
			:: true -> 
for11:				do
				:: true -> 
for12:
				od
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

