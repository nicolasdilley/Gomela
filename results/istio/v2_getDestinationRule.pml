



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			do
			:: true -> 
for11:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			od
		:: true;
		fi
	od;
	goto stop_process
stop_process:}

