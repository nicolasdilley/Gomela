#define flows  ??

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



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
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [len(flows) - 1] of {int};
		_ch0.in = _ch0_in
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			do
			:: true -> 
for10:				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					break
				:: true;
				fi
			od
		fi
	:: true;
	fi;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: dsp_runnerChan.in!0 -> 
			break
		:: true -> 
			break
		od
	od;
	
	if
	:: 0 != -1 && len() - 1-1 != -1 -> 
				for(i : 0.. len() - 1-1) {
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

