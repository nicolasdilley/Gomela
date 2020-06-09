



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:
		od
	od;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process
stop_process:}

