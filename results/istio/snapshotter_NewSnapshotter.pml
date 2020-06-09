



init { 
	bool state = false;
	int i;
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
	goto stop_process
stop_process:}

