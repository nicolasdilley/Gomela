#define lb_for41_0  -1
#define ub_for41_1  -1

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
	run Anonymous0(_ch0);
	goto stop_process
stop_process:}

proctype tickerrun1(Chandef c;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
			chan child_ttick10 = [0] of {int};
			run ttick1(child_ttick10);
			child_ttick10?0;
			break
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:	child!0;
stop_process:
}
proctype ttick1(chan child) {
	bool closed; 
	int i;
	do
	:: c.in!0 -> 
		c.sending?state;
		break
	:: true -> 
		break
	od;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_tickerrun11 = [0] of {int};
	run tickerrun1(_ch0,child_tickerrun11);
	child_tickerrun11?0;
	_ch0.closing!true;
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
