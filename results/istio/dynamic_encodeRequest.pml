



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			goto stop_process
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
	do
	:: true -> 
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	goto stop_process
stop_process:}

