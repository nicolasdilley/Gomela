#define lb_for147_0  -1
#define ub_for147_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [s.concurrency] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
		for(i : 0.. s.concurrency-1) {
for10:		chan child_screateWorker20 = [0] of {int};
		run screateWorker2(_ch0,child_screateWorker20);
		child_screateWorker20?0
	};
for10_exit:Loop:		do
	:: true -> 
for20:		do
		:: true -> 
			break
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: _ch0.in!0 -> 
			_ch0.sending?state;
			break
		:: true -> 
			goto Loop;
			break
		od;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for20_exit:;
	_ch0.closing!true;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	goto stop_process;
	
	if
	:: true -> 
		_ch0.closing!true
	:: true;
	fi
stop_process:}

proctype screateWorker2(Chandef taskCh;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
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
