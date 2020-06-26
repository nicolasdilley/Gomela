
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: 0 != -1 && len(mws) - 1 != -1 -> 
				for(i : 0.. len(mws) - 1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: true -> 
			run Anonymous0()
		:: true;
		fi;
		
		if
		:: true -> 
			run Anonymous1()
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous2()
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous3()
	:: true;
	fi
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
proctype Anonymous2() {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
		fi
	fi;
	
	if
	:: true -> 
		_ch0.in!0
	:: true;
	fi;
stop_process:
}
proctype Anonymous3() {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			_ch0.in!0;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			_ch0.in!0;
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			_ch0.in!0
		:: true;
		fi
	fi;
stop_process:
}
