
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [tableDefinitions] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	run Anonymous0(tableChan);
	run Anonymous1(tableChan);
	
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
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for10:		_ch0.in!0
	od;
		for(i : 1.. tableDefinitions) {
for20:		run Anonymous2(_ch0)
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef tableChan) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1(Chandef tableChan) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous2(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in?0;
	
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
stop_process:
}
