#define lb_for229_0  -1
#define ub_for229_1  -1
#define lb_for241_2  -1
#define ub_for241_3  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for229_0 != -1 && ub_for229_1 != -1 -> 
				for(i : lb_for229_0.. ub_for229_1) {
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			
			if
			:: lb_for241_2 != -1 && ub_for241_3 != -1 -> 
								for(i : lb_for241_2.. ub_for241_3) {
for11:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od
				}
			:: else -> 
				do
				:: true -> 
for11:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od
				:: true -> 
					break
				od
			fi;
for11_exit:
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			
			if
			:: lb_for241_2 != -1 && ub_for241_3 != -1 -> 
								for(i : lb_for241_2.. ub_for241_3) {
for11:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od
				}
			:: else -> 
				do
				:: true -> 
for11:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od
				:: true -> 
					break
				od
			fi;
for11_exit:
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

