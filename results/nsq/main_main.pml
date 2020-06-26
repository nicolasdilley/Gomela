#define lb_for84_0  -1
#define ub_for84_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	do
	:: true -> 
for10:
	od;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
		for(i : 0.. GOMAXPROCS_runtime(0)-1) {
for20:		run Anonymous0(_ch0,_ch1);
		_ch1.in?0
	};
for20_exit:	_ch0.closing!true
stop_process:}

proctype mainpubWorker7(Chandef rdyChan;Chandef goChan;chan child) {
	bool closed; 
	int i;
	rdyChan.in!0;
	rdyChan.sending?state;
	do
	:: true -> 
for21:		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for21_exit:	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	chan child_mainpubWorker70 = [0] of {int};
	run mainpubWorker7(_ch1,_ch0,child_mainpubWorker70);
	child_mainpubWorker70?0;
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
