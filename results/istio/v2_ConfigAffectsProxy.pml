



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
		fi;
		

		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		:: true -> 
			goto stop_process
		fi
	od;
	goto stop_process
stop_process:}

