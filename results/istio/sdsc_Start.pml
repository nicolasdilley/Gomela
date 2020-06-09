#define lb_for94_0  -1
#define ub_for94_1  -1




init { 
	bool state = false;
	int i;
	run Anonymous0()
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: lb_for94_0 != -1 && ub_for94_1 != -1 -> 
				for(i : lb_for94_0.. ub_for94_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
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
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:stop_process:
}
