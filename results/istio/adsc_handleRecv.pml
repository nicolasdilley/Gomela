#define lb_for320_0  -1
#define ub_for320_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for320_0 != -1 && ub_for320_1 != -1 -> 
				for(i : lb_for320_0.. ub_for320_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for11:				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				fi
			od;
			do
			:: true -> 
				break
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for11:				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				fi
			od;
			do
			:: true -> 
				break
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

