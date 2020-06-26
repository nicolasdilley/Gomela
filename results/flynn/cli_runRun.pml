
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
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		od
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
for20:
		od
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for30:
		od
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run Anonymous0()
	:: true;
	fi;
	run Anonymous1();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	Chandef _ch0;
	chan _ch0_in = [1] of {int};
	_ch0.in = _ch0_in;
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	Chandef _ch1;
	chan _ch1_in = [1] of {int};
	_ch1.in = _ch1_in;
	_ch1.in?0;
stop_process:
}
