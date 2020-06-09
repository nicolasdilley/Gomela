#define lb_for138_0  -1
#define ub_for138_1  -1
#define lb_for159_2  -1
#define ub_for159_3  -1
#define lb_for164_4  -1
#define ub_for164_5  -1




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
	od;
	
	if
	:: lb_for138_0 != -1 && ub_for138_1 != -1 -> 
				for(i : lb_for138_0.. ub_for138_1) {
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
	:: lb_for159_2 != -1 && ub_for159_3 != -1 -> 
				for(i : lb_for159_2.. ub_for159_3) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: lb_for164_4 != -1 && ub_for164_5 != -1 -> 
				for(i : lb_for164_4.. ub_for164_5) {
for40:
		}
	:: else -> 
		do
		:: true -> 
for40:
		:: true -> 
			break
		od
	fi;
for40_exit:
stop_process:}

