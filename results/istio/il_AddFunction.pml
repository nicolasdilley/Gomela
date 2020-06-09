#define lb_for114_0  -1
#define ub_for114_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for114_0 != -1 && ub_for114_1 != -1 -> 
				for(i : lb_for114_0.. ub_for114_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for11:				
				if
				:: 0 != -1 && int(Size_a())-1 != -1 -> 
										for(i : 0.. int(Size_a())-1) {
for12:
					}
				:: else -> 
					do
					:: true -> 
for12:
					:: true -> 
						break
					od
				fi;
for12_exit:
			od
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
			do
			:: true -> 
for11:				
				if
				:: 0 != -1 && int(Size_a())-1 != -1 -> 
										for(i : 0.. int(Size_a())-1) {
for12:
					}
				:: else -> 
					do
					:: true -> 
for12:
					:: true -> 
						break
					od
				fi;
for12_exit:
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

