
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
outer:			for(i : 0.. session.TotalParts-1) {
for10:		do
		:: _ch0.in?0 -> 
			goto outer;
			break
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			goto outer
		:: true;
		fi;
		run Anonymous0(_ch0)
	};
for10_exit:;
	
	if
	:: true -> 
		do
		:: _ch0.in?0 -> 
			break
		:: true -> 
			break
		od
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
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: _ch0.in!0 -> 
			break
		:: true -> 
			break
		od;
		goto stop_process
	:: true;
	fi;
stop_process:
}
