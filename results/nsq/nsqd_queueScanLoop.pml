#define lb_for603_0  -1
#define ub_for603_1  -1
#define lb_for665_2  -1
#define ub_for665_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch1_in = [getOpts_n().QueueScanSelectionCount] of {int};
	bool state = false;
	chan child_nresizePool40 = [0] of {int};
	chan _ch2_in = [0] of {int};
	chan _ch0_in = [getOpts_n().QueueScanSelectionCount] of {int};
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
	run nresizePool4(_ch0,_ch1,_ch2,child_nresizePool40);
	child_nresizePool40?0;
	do
	:: true -> 
for20:		do
		:: true -> 
			break
		:: true -> 
			chan child_nresizePool41 = [0] of {int};
			run nresizePool4(_ch0,_ch1,_ch2,child_nresizePool41);
			child_nresizePool41?0;
			break
		:: true -> 
			goto exit;
			break
		od;
loop:				do
		:: true -> 
for21:			_ch0.in!0;
			_ch0.sending?state
		od;
		
		if
		:: 0 != -1 && num-1 != -1 -> 
						for(i : 0.. num-1) {
for22:
			}
		:: else -> 
			do
			:: true -> 
for22:
			:: true -> 
				break
			od
		fi;
for22_exit:		
		if
		:: true -> 
			goto loop
		:: true;
		fi
	od;
for20_exit:exit:	;
	_ch2.closing!true
stop_process:}

proctype nresizePool4(Chandef workCh;Chandef responseCh;Chandef closeCh;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			break
		:: true -> 
			
			if
			:: true -> 
				closeCh.in!0;
				closeCh.sending?state
			fi
		fi
	od;
for10_exit:	child!0;
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
