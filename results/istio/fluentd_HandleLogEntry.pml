



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:
		od;
		do
		:: true -> 
			break
		:: true -> 
			break
		od
	od;
	goto stop_process
stop_process:}

