



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
	do
	:: true -> 
for10:
	od;
	do
	:: true -> 
for20:		do
		:: true -> 
for21:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od
	od;
	do
	:: true -> 
for30:
	od;
	do
	:: true -> 
for40:
	od;
	
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
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

