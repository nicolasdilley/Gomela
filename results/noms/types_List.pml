#define lb_for42_0  -1
#define ub_for42_1  -1
#define lb_for98_2  -1
#define ub_for98_3  -1

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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous0(_ch0,_ch1);
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0;
			
			if
			:: lb_for98_2 != -1 && ub_for98_3 != -1 -> 
								for(i : lb_for98_2.. ub_for98_3) {
for21:
				}
			:: else -> 
				do
				:: true -> 
for21:
				:: true -> 
					break
				od
			fi;
for21_exit:			do
			:: true -> 
for22:
			od
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	cc.in!0;
	cc.sending?state;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	sc.in!0;
	sc.sending?state;
stop_process:
}
proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
		for(i : lb_for42_0.. ub_for42_1) {
for10:		_ch0.in!0;
		_ch0.sending?state;
		run Anonymous0(_ch0,_ch1);
		_ch1.in!0;
		_ch1.sending?state;
				for(i : 1.. edit.inserted) {
for11:			run Anonymous1(_ch0,_ch1)
		};
		
		if
		:: true -> 
			sc.in!0;
			sc.sending?state
		:: true;
		fi;
		run Anonymous2(_ch0,_ch1)
	};
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
