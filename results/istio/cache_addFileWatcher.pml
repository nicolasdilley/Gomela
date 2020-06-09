#define lb_for355_0  -1
#define ub_for355_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0()
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: lb_for355_0 != -1 && ub_for355_1 != -1 -> 
				for(i : lb_for355_0.. ub_for355_1) {
for10:			do
			:: true -> 
				do
				:: true -> 
for11:
				od;
				break
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				do
				:: true -> 
for11:
				od;
				break
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:stop_process:
}
