



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
					break
				:: true;
				fi
			od
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
	goto stop_process
stop_process:}

