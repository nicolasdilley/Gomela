



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		
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
		do
		:: true -> 
for10:
		od;
		
		if
		:: true -> 
			do
			:: true -> 
for20:
			od
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

