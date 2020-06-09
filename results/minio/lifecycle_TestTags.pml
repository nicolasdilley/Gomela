



init { 
	bool state = false;
	int i;
	
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
for20:		do
		:: true -> 
for21:			
			if
			:: true -> 
				break
			:: true;
			fi
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	goto stop_process
stop_process:}

