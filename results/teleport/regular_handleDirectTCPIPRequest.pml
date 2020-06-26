
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [2] of {int};
	bool state = false;
	int i;
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
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run Anonymous0(_ch0);
	run Anonymous1(_ch0);
	
	if
	:: 0 != -1 && 2-1 != -1 -> 
				for(i : 0.. 2-1) {
for10:			do
			:: _ch0.in?0 -> 
				break
			:: true -> 
				goto for10_exit
			:: true -> 
				goto for10_exit
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: _ch0.in?0 -> 
				break
			:: true -> 
				goto for10_exit
			:: true -> 
				goto for10_exit
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi
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
