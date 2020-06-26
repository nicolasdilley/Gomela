#define lb_for384_0  -1
#define ub_for384_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [fs.Config.Checkers] of {int};
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch2;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
		for(i : 0.. fs.Config.Checkers-1) {
for10:		run Anonymous0(_ch0,_ch1,_ch2)
	};
for10_exit:	_ch0.in!0;
	_ch0.sending?state;
	_ch0.closing!true;
	_ch1.closing!true;
	_ch1.in?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
	do
	:: true -> 
for12:		_ch0.in!0;
		_ch0.sending?state
	od;
stop_process:
}
proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
		for(i : lb_for384_0.. ub_for384_1) {
for11:		do
		:: _ch0.in?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: _ch1.in!0 -> 
					_ch1.sending?state;
					break
				:: true -> 
					break
				od
			:: true;
			fi;
			
			if
			:: true -> 
				run Anonymous0(_ch0,_ch1,_ch2)
			:: true;
			fi;
			break
		:: _ch2.in?0 -> 
			goto stop_process
		od
	};
for11_exit:stop_process:
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
