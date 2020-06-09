#define lb_for1293_0  -1
#define ub_for1293_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && mult * b.N-1 != -1 -> 
				for(i : 0.. mult * b.N-1) {
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
	:: lb_for1293_0 != -1 && ub_for1293_1 != -1 -> 
				for(i : lb_for1293_0.. ub_for1293_1) {
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
stop_process:}

