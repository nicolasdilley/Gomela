



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
		do
		:: true -> 
for10:
		od
	:: true;
	fi;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		fi
	od;
	goto stop_process
stop_process:}

