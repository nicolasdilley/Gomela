#define lb_for309_0  -1
#define ub_for309_1  -1




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
	od;
	
	if
	:: lb_for309_0 != -1 && ub_for309_1 != -1 -> 
				for(i : lb_for309_0.. ub_for309_1) {
for30:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

