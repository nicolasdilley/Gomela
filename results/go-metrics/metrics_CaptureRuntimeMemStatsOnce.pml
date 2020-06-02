#define lb_for118_0  ??
#define ub_for118_1  ??
#define lb_for123_2  ??
#define ub_for123_3  ??




init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		
		if
		:: 0 != -1 && uint32(len(memStats.PauseNs)) != -1 -> 
						for(i : 0.. uint32(len(memStats.PauseNs))+1) {
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
for10_exit:
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: lb_for118_0 != -1 && ub_for118_1 != -1 -> 
								for(i : lb_for118_0.. ub_for118_1+1) {
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
for20_exit:
		:: true;
		fi;
		
		if
		:: lb_for123_2 != -1 && ub_for123_3 != -1 -> 
						for(i : lb_for123_2.. ub_for123_3+1) {
for30:
			}
		:: else -> 
			do
			:: true -> 
for30:
			:: true -> 
				break
			od
		fi;
for30_exit:
	fi
stop_process:}

