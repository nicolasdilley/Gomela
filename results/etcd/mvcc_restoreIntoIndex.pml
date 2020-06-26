
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [1] of {int};
	chan _ch1_in = [restoreChunkKeys] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	run Anonymous0(_ch1,_ch0);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch1;Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: _ch1.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch1.in?0;
			
			if
			:: true -> 
				do
				:: true -> 
for11:					
					if
					:: true -> 
						break
					:: true;
					fi
				od
			:: true;
			fi
		fi
	od;
	_ch0.in!0;
stop_process:
}
