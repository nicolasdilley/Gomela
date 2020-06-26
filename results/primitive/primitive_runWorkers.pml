
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [wn] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
		for(i : 0.. wn-1) {
for10:
	};
for10_exit:	
	if
	:: 0 != -1 && wn-1 != -1 -> 
				for(i : 0.. wn-1) {
for20:			_ch0.in?0
		}
	:: else -> 
		do
		:: true -> 
for20:			_ch0.in?0
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

