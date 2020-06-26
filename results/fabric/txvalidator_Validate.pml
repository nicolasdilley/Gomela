
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run Anonymous0(_ch0);
	
	if
	:: 0 != -1 && block.Data.Data-1 != -1 -> 
				for(i : 0.. block.Data.Data-1) {
for20:			_ch0.in?0
		}
	:: else -> 
		do
		:: true -> 
for20:			_ch0.in?0
		:: true -> 
			break
		od
	fi;
for20_exit:	
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

proctype vvalidateTx2(Chandef results;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		results.in!0;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		results.in!0;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				results.in!0;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				results.in!0;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				results.in!0;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					results.in!0;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						results.in!0;
						goto stop_process
					:: true;
					fi;
					
					if
					:: true -> 
						results.in!0;
						goto stop_process
					:: true;
					fi
				:: true -> 
					results.in!0;
					goto stop_process
				fi
			fi;
			
			if
			:: true -> 
				results.in!0;
				goto stop_process
			:: true;
			fi;
			results.in!0;
			goto stop_process
		:: true -> 
			results.in!0;
			goto stop_process
		fi
	fi;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_vvalidateTx20 = [0] of {int};
	run vvalidateTx2(_ch0,child_vvalidateTx20);
	child_vvalidateTx20?0;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		run Anonymous0(_ch0)
	od;
stop_process:
}
