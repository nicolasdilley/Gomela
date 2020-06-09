#define lb_for243_0  -1
#define ub_for243_1  -1




init { 
	bool state = false;
	int i;
	run Anonymous0()
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: lb_for243_0 != -1 && ub_for243_1 != -1 -> 
				for(i : lb_for243_0.. ub_for243_1) {
for10:			do
			:: true -> 
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
