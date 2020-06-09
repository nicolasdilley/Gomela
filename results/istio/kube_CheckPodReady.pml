



init { 
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od;
		
		if
		:: true -> 
			do
			:: true -> 
for20:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			od
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	fi
stop_process:}

