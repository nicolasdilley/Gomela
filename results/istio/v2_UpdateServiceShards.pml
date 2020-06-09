



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:			do
			:: true -> 
for12:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				do
				:: true -> 
for13:
				od
			od
		od
	od;
	goto stop_process
stop_process:}

