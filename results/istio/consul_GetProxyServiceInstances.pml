



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
			if
			:: true -> 
				do
				:: true -> 
for12:					
					if
					:: true -> 
						break
					:: true;
					fi
				od
			:: true;
			fi
		od
	od;
	goto stop_process
stop_process:}

