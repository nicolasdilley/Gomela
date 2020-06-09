



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
	
	if
	:: true -> 
		do
		:: true -> 
for20:			do
			:: true -> 
for21:
			od
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

