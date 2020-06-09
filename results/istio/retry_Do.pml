#define lb_for111_0  -1
#define ub_for111_1  -1




init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	
	if
	:: lb_for111_0 != -1 && ub_for111_1 != -1 -> 
				for(i : lb_for111_0.. ub_for111_1) {
for20:			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:
stop_process:}

