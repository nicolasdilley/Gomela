#define lb_for114_0  -1
#define ub_for114_1  -1
#define lb_for141_2  -1
#define ub_for141_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [n] of {int};
	chan _ch1_in = [n] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0,processpipe);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
		for(i : 0.. n-1) {
for20:		run Anonymous1(_ch0,_ch1)
	};
for20_exit:	do
	:: true -> 
for30:		_ch1.in!0;
		_ch1.sending?state
	od;
	_ch1.closing!true;
	_ch0.closing!true;
	do
	:: true -> 
for40:		do
		:: true -> 
for41:
		od
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef processpipe) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		_ch0.in?0;
		
		if
		:: true -> 
			break
		fi
	od;
for10_exit:stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
for21:		_ch1.in?0;
		
		if
		:: true -> 
			_ch0.in!0;
			_ch0.sending?state
		:: true -> 
			break
		fi
	od;
for21_exit:stop_process:
}
proctype chanMonitor(Chandef ch) {
	bool closed; 
	int i;
	state = false;
	do
	:: true -> 
		if
		:: state -> 
end:			if
			:: ch.sending!state -> 
				assert(false)
			:: ch.closing?true -> 
				assert(false)
			:: ch.in!0;
			:: ch.is_closed!state;
			fi
		:: else -> 
end1:			if
			:: ch.sending!state;
			:: ch.closing?true -> 
				state = true
			:: ch.is_closed!state;
			fi
		fi
	od;
stop_process:
}
