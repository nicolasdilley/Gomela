



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
	do
	:: true -> 
for20:		do
		:: true -> 
for21:
		od;
		
		if
		:: true -> 
			do
			:: true -> 
for22:				
				if
				:: true -> 
					break
				:: true;
				fi
			od
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: true -> 
for23:
			od
		:: true;
		fi
	od;
	goto stop_process
stop_process:}

