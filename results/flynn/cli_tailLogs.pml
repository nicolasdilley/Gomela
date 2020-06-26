#define lb_for135_0  -1
#define ub_for135_1  -1
#define lb_for150_2  -1
#define ub_for150_3  -1

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
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run go_cliscanLogs3(_ch0);
	run go_cliscanLogs3(_ch1);
	do
	:: true -> 
for20:		do
		:: _ch0.in?0 -> 
			break
		:: _ch1.in?0 -> 
			break
		od;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for20_exit:	do
	:: true -> 
for30:		

		if
		:: true;
		:: true;
		fi
	od
stop_process:}

proctype go_cliscanLogs3(Chandef output) {
	bool closed; 
	int i;
	
	if
	:: lb_for135_0 != -1 && ub_for135_1 != -1 -> 
				for(i : lb_for135_0.. ub_for135_1) {
for10:			output.in!0;
			output.sending?state
		}
	:: else -> 
		do
		:: true -> 
for10:			output.in!0;
			output.sending?state
		:: true -> 
			break
		od
	fi;
for10_exit:	output.closing!true;
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
