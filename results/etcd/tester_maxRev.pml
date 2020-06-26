
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [clus.Members] of {int};
	chan _ch1_in = [clus.Members] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	do
	:: true -> 
for10:		run Anonymous0(_ch1,_ch0)
	od;
	
	if
	:: 0 != -1 && clus.Members-1 != -1 -> 
				for(i : 0.. clus.Members-1) {
for20:			_ch0.in?0;
			_ch1.in?0
		}
	:: else -> 
		do
		:: true -> 
for20:			_ch0.in?0;
			_ch1.in?0
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch1;Chandef _ch0) {
	bool closed; 
	int i;
	_ch1.in!0;
	_ch0.in!0;
stop_process:
}
