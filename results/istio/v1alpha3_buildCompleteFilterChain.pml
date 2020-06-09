



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: 0 != -1 && len(opt.networkFilters) - 1-1 != -1 -> 
												for(i : 0.. len(opt.networkFilters) - 1-1) {
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
			fi
		fi
	od;
	goto stop_process
stop_process:}

