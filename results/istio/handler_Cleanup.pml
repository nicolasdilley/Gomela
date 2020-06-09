#define lb_for195_0  -1
#define ub_for195_1  -1




init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	do
	:: true -> 
for20:		run Anonymous0()
	od
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: lb_for195_0 != -1 && ub_for195_1 != -1 -> 
				for(i : lb_for195_0.. ub_for195_1) {
for21:
		}
	:: else -> 
		do
		:: true -> 
for21:
		:: true -> 
			break
		od
	fi;
for21_exit:stop_process:
}
