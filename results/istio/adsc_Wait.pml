#define lb_for804_0  -1
#define ub_for804_1  -1




init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	
	if
	:: lb_for804_0 != -1 && ub_for804_1 != -1 -> 
				for(i : lb_for804_0.. ub_for804_1) {
for20:			do
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				fi;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				fi;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for20_exit:
stop_process:}

