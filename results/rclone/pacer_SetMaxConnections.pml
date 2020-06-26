#define n  ??

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
		Chandef _ch0;
		chan _ch0_in = [n] of {int};
		_ch0.in = _ch0_in;
		
		if
		:: 0 != -1 && n-1 != -1 -> 
						for(i : 0.. n-1) {
for10:				_ch0.in!0
			}
		:: else -> 
			do
			:: true -> 
for10:				_ch0.in!0
			:: true -> 
				break
			od
		fi;
for10_exit:
	fi
stop_process:}

