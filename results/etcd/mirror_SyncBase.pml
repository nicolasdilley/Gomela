#define lb_for86_0  -1
#define ub_for86_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [1024] of {int};
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	
	if
	:: true -> 
		
		if
		:: true -> 
			_ch1.in!0;
			_ch1.sending?state;
			_ch0.closing!true;
			_ch1.closing!true;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run Anonymous0(_ch0,_ch1);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			_ch1.in!0;
			_ch1.sending?state;
			goto stop_process
		:: true;
		fi;
		_ch0.in!0;
		_ch0.sending?state;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for10_exit:	_ch0.closing!true;
	_ch1.closing!true;
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
