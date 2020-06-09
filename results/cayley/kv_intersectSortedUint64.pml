#define lb_for932_0  -1
#define ub_for932_1  -1




init { 
	bool state = false;
	int i;
outer:		do
	:: true -> 
for10:		
		if
		:: lb_for932_0 != -1 && ub_for932_1 != -1 -> 
						for(i : lb_for932_0.. ub_for932_1) {
for11:				
				if
				:: true -> 
					goto outer
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for11:				
				if
				:: true -> 
					goto outer
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for11_exit:
	od;
	goto stop_process
stop_process:}

