
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [goMaxProcs] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
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
	_ch0.in = _ch0_in;
		for(i : 0.. goMaxProcs-1) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run Anonymous0(_ch0)
	};
for20_exit:	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			run Anonymous1(_ch0)
		fi
	od;
	goto stop_process;
	do
	:: true -> 
for10:
	od
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
