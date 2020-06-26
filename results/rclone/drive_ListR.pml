#define lb_for1856_0  -1
#define ub_for1856_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [listRInputBuffer] of {int};
	chan _ch1_in = [fs.Config.Checkers] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	_ch0.in!0;
	_ch0.sending?state;
		for(i : 0.. fs.Config.Checkers-1) {
for10:
	};
for10_exit:	run Anonymous0(_ch0,_ch1);
	
	if
	:: 0 != -1 && fs.Config.Checkers-1 != -1 -> 
				for(i : 0.. fs.Config.Checkers-1) {
for30:			_ch1.in?0;
			
			if
			:: true -> 
				_ch0.closing!true
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			_ch1.in?0;
			
			if
			:: true -> 
				_ch0.closing!true
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	_ch1.closing!true;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	
	if
	:: lb_for1856_0 != -1 && ub_for1856_1 != -1 -> 
				for(i : lb_for1856_0.. ub_for1856_1) {
for20:			do
			:: true -> 
for21:				_ch0.in!0;
				_ch0.sending?state
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
for21:				_ch0.in!0;
				_ch0.sending?state
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: true -> 
		_ch0.closing!true
	:: true;
	fi;
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
