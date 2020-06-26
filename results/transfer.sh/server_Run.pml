
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
		run Anonymous0(term)
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		od
	fi;
	
	if
	:: true -> 
		run Anonymous1(term)
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous2(term)
	:: true;
	fi;
	_ch0.in = _ch0_in;
	
	if
	:: true -> 
		_ch0.in?0
	fi
stop_process:}

proctype Anonymous0(Chandef term) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1(Chandef term) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous2(Chandef term) {
	bool closed; 
	int i;
stop_process:
}
