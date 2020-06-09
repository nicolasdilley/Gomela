#define lb_for83_0  -1
#define ub_for83_1  -1
#define lb_for85_2  -1
#define ub_for85_3  -1




init { 
	bool state = false;
	int i;
	
	if
	:: lb_for83_0 != -1 && ub_for83_1 != -1 -> 
				for(i : lb_for83_0.. ub_for83_1) {
for10:			
			if
			:: lb_for85_2 != -1 && ub_for85_3 != -1 -> 
								for(i : lb_for85_2.. ub_for85_3) {
for11:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od;
					break
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
					break
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
			:: lb_for85_2 != -1 && ub_for85_3 != -1 -> 
								for(i : lb_for85_2.. ub_for85_3) {
for11:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od;
					break
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
					break
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

