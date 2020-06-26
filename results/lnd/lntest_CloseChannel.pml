
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	
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
	_ch1.in = _ch1_in;
	run Anonymous0(_ch0,_ch1);
	do
	:: true -> 
		goto stop_process
	:: _ch0.in?0 -> 
		goto stop_process
	:: _ch1.in?0 -> 
		goto stop_process
	od
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
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
		_ch0.in!0;
		goto stop_process
	:: true;
	fi;
	
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
	fi;
	_ch1.in!0;
stop_process:
}
