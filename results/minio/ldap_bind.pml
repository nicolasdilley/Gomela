



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for10:			
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
		do
		:: true -> 
for20:			
			if
			:: true -> 
				do
				:: true -> 
for21:
				od
			fi;
			do
			:: true -> 
for22:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			od
		od
	:: true;
	fi;
	goto stop_process
stop_process:}

