#define lb_for172_0  -1
#define ub_for172_1  -1




init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run Anonymous0();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: lb_for172_0 != -1 && ub_for172_1 != -1 -> 
				for(i : lb_for172_0.. ub_for172_1) {
for20:			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for20_exit:stop_process:
}
