
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [numOfMasterTablets] of {int};
	chan _ch1_in = [numOfMasterTablets] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	do
	:: true -> 
for10:		run Anonymous0(_ch0,_ch1)
	od;
	_ch0.closing!true;
	_ch1.closing!true;
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0
		fi
	od;
	do
	:: _ch1.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch1.in?0
		fi
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. execResult.SuccessShards) {
for40:		run Anonymous2(_ch0,_ch1)
	}
stop_process:}

proctype execexecuteOneTablet5(Chandef errChan;Chandef successChan;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		errChan.in!0;
		errChan.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		errChan.in!0;
		errChan.sending?state;
		goto stop_process
	:: true;
	fi;
	successChan.in!0;
	successChan.sending?state;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	chan child_execexecuteOneTablet50 = [0] of {int};
	run execexecuteOneTablet5(_ch0,_ch1,child_execexecuteOneTablet50);
	child_execexecuteOneTablet50?0;
stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
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
