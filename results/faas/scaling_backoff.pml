#define attempts  -1




init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && attempts-1 != -1 -> 
				for(i : 0.. attempts-1) {
for10:			
			if
			:: true -> 
				break
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

