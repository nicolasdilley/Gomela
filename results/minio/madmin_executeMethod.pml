



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		do
		:: true -> 
for11:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

