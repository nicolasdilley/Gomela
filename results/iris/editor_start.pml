#define lb_for184_0  -1
#define ub_for184_1  -1
#define lb_for193_2  -1
#define ub_for193_3  -1




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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			run Anonymous0();
			
			if
			:: true -> 
				run Anonymous1()
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: lb_for184_0 != -1 && ub_for184_1 != -1 -> 
				for(i : lb_for184_0.. ub_for184_1) {
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
proctype Anonymous1() {
	bool closed; 
	int i;
	
	if
	:: lb_for193_2 != -1 && ub_for193_3 != -1 -> 
				for(i : lb_for193_2.. ub_for193_3) {
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
for20_exit:stop_process:
}
