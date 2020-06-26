#define lb_for125_0  -1
#define ub_for125_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [setting.AlertingMaxAttempts * 2] of {int};
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	_ch1.in!0;
	_ch1.sending?state;
		for(i : lb_for125_0.. ub_for125_1) {
for10:		do
		:: true -> 
			do
			:: true -> 
				chan child_eendJob30 = [0] of {int};
				run eendJob3(_ch0,child_eendJob30);
				child_eendJob30?0;
				goto stop_process
			:: _ch1.in?0 -> 
				chan child_eendJob31 = [0] of {int};
				run eendJob3(_ch0,child_eendJob31);
				child_eendJob31?0;
				goto stop_process
			od;
			break
		:: _ch1.in?0 -> 
			
			if
			:: true -> 
				chan child_eendJob32 = [0] of {int};
				run eendJob3(_ch0,child_eendJob32);
				child_eendJob32?0;
				goto stop_process
			:: true;
			fi;
			break
		od
	};
for10_exit:
stop_process:}

proctype eendJob3(Chandef cancelChan;chan child) {
	bool closed; 
	int i;
	cancelChan.closing!true;
	do
	:: true -> 
for11:
	od;
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
