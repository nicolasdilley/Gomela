#define lb_for149_0  -1
#define ub_for149_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [fs.Config.Checkers] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
		for(i : 0.. fs.Config.Checkers-1) {
for10:		run Anonymous0(_ch0)
	};
for10_exit:	_ch0.in!0;
	_ch0.sending?state;
	run Anonymous2(_ch0);
	_ch0.closing!true;
	
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
	do
	:: true -> 
for12:		do
		:: true -> 
			break
		:: _ch0.in!0 -> 
			_ch0.sending?state;
			break
		od
	od;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
		for(i : lb_for149_0.. ub_for149_1) {
for11:		do
		:: true -> 
			goto stop_process
		:: _ch0.in?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				run Anonymous0(_ch0)
			:: true;
			fi;
			break
		od
	};
for11_exit:stop_process:
}
proctype Anonymous2(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0
		fi
	od;
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
