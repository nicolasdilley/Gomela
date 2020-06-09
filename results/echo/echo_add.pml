#define lb_for77_0  -1
#define ub_for77_1  -1




init { 
	bool state = false;
	int i;
	
	if
	:: len(path) != -1 && l-1-1 != -1 -> 
				for(i : len(path).. l-1-1) {
for10:			
			if
			:: true -> 
				
				if
				:: lb_for77_0 != -1 && ub_for77_1 != -1 -> 
										for(i : lb_for77_0.. ub_for77_1) {
for11:
					}
				:: else -> 
					do
					:: true -> 
for11:
					:: true -> 
						break
					od
				fi;
for11_exit:
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: lb_for77_0 != -1 && ub_for77_1 != -1 -> 
										for(i : lb_for77_0.. ub_for77_1) {
for11:
					}
				:: else -> 
					do
					:: true -> 
for11:
					:: true -> 
						break
					od
				fi;
for11_exit:
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

