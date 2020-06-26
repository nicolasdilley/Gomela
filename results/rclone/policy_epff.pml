#define upstreams  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	do
	:: true -> 
for10:		run Anonymous0(_ch0)
	od;
		for(i : 0.. upstreams-1) {
for20:		_ch0.in?0;
		
		if
		:: true -> 
			run Anonymous1(_ch0)
		:: true;
		fi
	};
for20_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
	_ch0.sending?state;
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && num-1 != -1 -> 
				for(i : 0.. num-1) {
for21:			_ch0.in?0
		}
	:: else -> 
		do
		:: true -> 
for21:			_ch0.in?0
		:: true -> 
			break
		od
	fi;
for21_exit:	_ch0.closing!true;
stop_process:
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
