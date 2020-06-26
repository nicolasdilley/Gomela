
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
		for(i : 1.. uploadGroups) {
for10:		do
		:: true -> 
for11:			sem.in!0;
			run Anonymous0(sem,sem)
		od;
		
		if
		:: 0 != -1 && nParallel-1 != -1 -> 
						for(i : 0.. nParallel-1) {
for12:				sem.in!0
			}
		:: else -> 
			do
			:: true -> 
for12:				sem.in!0
			:: true -> 
				break
			od
		fi;
for12_exit:
	};
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [nParallel] of {int};
		_ch0.in = _ch0_in;
		do
		:: true -> 
for20:			_ch0.in!0;
			run Anonymous1(sem,_ch0)
		od;
		
		if
		:: 0 != -1 && nParallel-1 != -1 -> 
						for(i : 0.. nParallel-1) {
for30:				_ch0.in!0
			}
		:: else -> 
			do
			:: true -> 
for30:				_ch0.in!0
			:: true -> 
				break
			od
		fi;
for30_exit:
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef sem;Chandef sem) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1(Chandef sem;Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in?0;
stop_process:
}
