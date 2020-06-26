#define lb_for154_0  -1
#define ub_for154_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	int i;
	chan child_apppump10 = [0] of {int};
	bool state = false;
	run apppump1(child_apppump10);
	child_apppump10?0
stop_process:}

proctype apppump1(chan child) {
	bool closed; 
	int i;
	Chandef _ch0;
	chan _ch0_in = [0] of {int};
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous1(dst,_ch0,dst);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef dst;Chandef _ch0;Chandef dst) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			break
		:: true;
		fi;
		do
		:: maybeDst.in!0 -> 
			maybeDst.sending?state;
			break
		:: _ch0.in?0 -> 
			break
		od
	od;
for10_exit:	dst.closing!true;
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
