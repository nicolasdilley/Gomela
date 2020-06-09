#define lb_for149_0  -1
#define ub_for149_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [GOMAXPROCS_runtime(0)] of {int};
	chan _ch1_in = [GOMAXPROCS_runtime()] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous0(_ch0,_ch1);
	
	if
	:: 0 != -1 && GOMAXPROCS_runtime()-1 != -1 -> 
				for(i : 0.. GOMAXPROCS_runtime()-1) {
for20:			run Anonymous1(_ch0,_ch1)
		}
	:: else -> 
		do
		:: true -> 
for20:			run Anonymous1(_ch0,_ch1)
		:: true -> 
			break
		od
	fi;
for20_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	
	if
	:: lb_for149_0 != -1 && ub_for149_1 != -1 -> 
				for(i : lb_for149_0.. ub_for149_1) {
for10:			do
			:: true -> 
				goto stop_process
			:: _ch0.in!0 -> 
				_ch0.sending?state;
				break
			od;
			do
			:: true -> 
				goto stop_process
			:: _ch1.in!0 -> 
				_ch1.sending?state;
				break
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				goto stop_process
			:: _ch0.in!0 -> 
				_ch0.sending?state;
				break
			od;
			do
			:: true -> 
				goto stop_process
			:: _ch1.in!0 -> 
				_ch1.sending?state;
				break
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	_ch1.closing!true;
	_ch0.closing!true;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: _ch1.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch1.in?0;
			do
			:: true -> 
for22:
			od
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
