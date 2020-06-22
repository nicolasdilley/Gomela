#define lb_for547_0  -1
#define ub_for547_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch1_in = [16] of {int};
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
	run Anonymous0(_ch0,_ch1,_ch2);
	do
	:: _ch1.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch1.in?0
		fi
	od;
	_ch0.in?0;
	goto stop_process;
	_ch2.closing!true
stop_process:}

proctype shenumerateQueuedBlobs2(Chandef dst;Chandef intr;chan child) {
	bool closed; 
	int i;
	
	if
	:: lb_for547_0 != -1 && ub_for547_1 != -1 -> 
				for(i : lb_for547_0.. ub_for547_1) {
for10:			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process;
	dst.closing!true;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0;Chandef _ch1;Chandef _ch2) {
	bool closed; 
	int i;
	chan child_shenumerateQueuedBlobs20 = [0] of {int};
	run shenumerateQueuedBlobs2(_ch1,_ch2,child_shenumerateQueuedBlobs20);
	child_shenumerateQueuedBlobs20?0;
	_ch0.in!0;
	_ch0.sending?state;
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
