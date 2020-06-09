



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
		fi
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
	do
	:: true -> 
for30:		do
		:: true -> 
for31:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od
	od;
	goto stop_process
stop_process:}

