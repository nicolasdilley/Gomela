#define lb_for123_0  -1
#define ub_for123_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [totalClients] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
		for(i : 1.. clients) {
for10:		run go_cmddoSTM3(_ch0,Results_r())
	};
	run Anonymous1(_ch0);
	r_Results__.closing!true
stop_process:}

proctype go_cmddoSTM3(Chandef requests;Chandef results) {
	bool closed; 
	int i;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	do
	:: requests.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			requests.in?0;
			results.in!0;
			results.sending?state
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && stmTotal-1 != -1 -> 
				for(i : 0.. stmTotal-1) {
for20:			
			if
			:: lb_for123_0 != -1 && ub_for123_1 != -1 -> 
								for(i : lb_for123_0.. ub_for123_1) {
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
for21_exit:			_ch0.in!0;
			_ch0.sending?state
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: lb_for123_0 != -1 && ub_for123_1 != -1 -> 
								for(i : lb_for123_0.. ub_for123_1) {
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
for21_exit:			_ch0.in!0;
			_ch0.sending?state
		:: true -> 
			break
		od
	fi;
for20_exit:	_ch0.closing!true;
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
