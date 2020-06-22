
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	run Anonymous0(_ch0,_ch1,_ch0,errc);
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0
		fi
	od;
	_ch1.in?0;
	do
	:: true -> 
for20:
	od;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
	do
	:: true -> 
for40:
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. wantRefs-1) {
for50:		run Anonymous1(_ch0,_ch1,_ch0,errc);
		do
		:: _ch0.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				_ch0.in?0;
				
				if
				:: true -> 
					break
				fi
			fi
		od;
		
		if
		:: true -> 
			break
		:: true;
		fi
	};
for50_exit:	
	if
	:: true -> 
		do
		:: true -> 
for60:
		od;
		do
		:: true -> 
for70:
		od;
		do
		:: true -> 
for80:
		od
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch0;Chandef errc) {
	bool closed; 
	int i;
	_ch1.in!0;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1;Chandef _ch0;Chandef errc) {
	bool closed; 
	int i;
stop_process:
}
