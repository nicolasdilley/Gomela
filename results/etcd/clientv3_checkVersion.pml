
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [eps] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for10:		run Anonymous0(_ch0)
	od;
	do
	:: true -> 
for20:		_ch0.in?0;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		_ch0.in!0;
		goto stop_process
	:: true;
	fi;
	
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
	:: true;
	fi;
	_ch0.in!0;
stop_process:
}
