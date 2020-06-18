
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [20] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
		for(i : 0.. 20-1) {
for10:		run go_mainSend3(_ch0)
	};
for10_exit:	run Anonymous1(_ch0);
	
	if
	:: 0 != -1 && 20-1 != -1 -> 
				for(i : 0.. 20-1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:
stop_process:}

proctype go_mainSend3(Chandef a) {
	bool closed; 
	int i;
	a.in!0;
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
stop_process:
}
