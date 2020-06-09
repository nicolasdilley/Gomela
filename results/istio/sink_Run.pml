#define lb_for56_0  -1
#define ub_for56_1  -1
#define lb_for62_2  -1
#define ub_for62_3  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for56_0 != -1 && ub_for56_1 != -1 -> 
				for(i : lb_for56_0.. ub_for56_1) {
for10:			
			if
			:: lb_for62_2 != -1 && ub_for62_3 != -1 -> 
								for(i : lb_for62_2.. ub_for62_3) {
for11:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for11:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for11_exit:
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: lb_for62_2 != -1 && ub_for62_3 != -1 -> 
								for(i : lb_for62_2.. ub_for62_3) {
for11:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for11:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od;
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for11_exit:
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

