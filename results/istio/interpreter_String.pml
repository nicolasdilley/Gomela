



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:
	od;
	
	if
	:: 0 != -1 && int(s.sp)-1 != -1 -> 
				for(i : 0.. int(s.sp)-1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: 0 != -1 && int()-1 != -1 -> 
				for(i : 0.. int()-1) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: 0 != -1 && int()-1 != -1 -> 
				for(i : 0.. int()-1) {
for40:
		}
	:: else -> 
		do
		:: true -> 
for40:
		:: true -> 
			break
		od
	fi;
for40_exit:	goto stop_process
stop_process:}

