



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:			
			if
			:: true -> 
				break
			:: true;
			fi
		od;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	od;
	goto stop_process
stop_process:}

