#define lb_for128_0  -1
#define ub_for128_1  -1




init { 
	bool state = false;
	int i;
	run Anonymous0()
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: lb_for128_0 != -1 && ub_for128_1 != -1 -> 
				for(i : lb_for128_0.. ub_for128_1) {
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
for10_exit:stop_process:
}
