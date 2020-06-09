



init { 
	bool state = false;
	int i;
	
	if
	:: 0 != -1 && uint32(len(p.imap))-1 != -1 -> 
				for(i : 0.. uint32(len(p.imap))-1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

