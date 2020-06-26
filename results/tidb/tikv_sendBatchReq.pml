
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [batches] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:
	od;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for20:		run Anonymous0(_ch0)
	od;
	

	if
	:: true;
	:: true;
	fi;
	
	if
	:: 0 != -1 && batches-1 != -1 -> 
				for(i : 0.. batches-1) {
for30:			_ch0.in?0
		}
	:: else -> 
		do
		:: true -> 
for30:			_ch0.in?0
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
