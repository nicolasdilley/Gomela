#define lb_for448_0  -1
#define ub_for448_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch3_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch3;
	Chandef _ch2;
	Chandef _ch1;
	Chandef _ch0;
	
	if
	:: true -> 
		c_done.closing!true;
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	_ch3.in = _ch3_in;
	run chanMonitor(_ch3);
	run Anonymous0(_ch0,_ch1,_ch2,_ch3);
	_ch2.closing!true;
	_ch3.in?0;
	c_done.closing!true
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2;Chandef _ch3) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: _ch0.in?0 -> 
			
			if
			:: true -> 
				_ch1.in!0;
				_ch1.sending?state;
				goto stop_process
			:: true;
			fi;
			break
		:: _ch2.in?0 -> 
			goto stop_process
		:: true -> 
			_ch1.in!0;
			_ch1.sending?state;
			goto stop_process
		:: true -> 
			_ch1.in!0;
			_ch1.sending?state;
			goto stop_process
		od
	od;
for10_exit:	_ch3.closing!true;
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
