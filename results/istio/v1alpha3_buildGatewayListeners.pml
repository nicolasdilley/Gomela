



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
for10:		do
		:: true -> 
for11:
		od;
		
		if
		:: true -> 
			do
			:: true -> 
for12:				
				if
				:: true -> 
					
					if
					:: 0 != -1 && len(tcpChainOpts)-1 != -1 -> 
												for(i : 0.. len(tcpChainOpts)-1) {
for13:
						}
					:: else -> 
						do
						:: true -> 
for13:
						:: true -> 
							break
						od
					fi;
for13_exit:
				fi
			od
		fi;
		do
		:: true -> 
for14:
		od
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:
	od;
	goto stop_process
stop_process:}

