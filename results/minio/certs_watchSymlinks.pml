#define lb_for100_0  -1
#define ub_for100_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: lb_for100_0 != -1 && ub_for100_1 != -1 -> 
				for(i : lb_for100_0.. ub_for100_1) {
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:stop_process:
}
