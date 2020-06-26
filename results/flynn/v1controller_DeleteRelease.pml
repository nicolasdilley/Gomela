
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_cStreamEvents20 = [0] of {int};
	chan _ch0_in = [0] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run cStreamEvents2(_ch0,child_cStreamEvents20);
	child_cStreamEvents20?0;
	
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
	do
	:: _ch0.in?0 -> 
		
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
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:}

proctype cStreamEvents2(Chandef output;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		od
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
