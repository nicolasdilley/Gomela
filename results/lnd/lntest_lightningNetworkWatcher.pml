#define lb_for897_0  -1
#define ub_for897_1  -1
#define lb_for913_2  -1
#define ub_for913_3  -1

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
	do
	:: true -> 
for20:		do
		:: _ch0.in?0 -> 
						for(i : 1.. graphUpdate.ChannelUpdates) {
for21:								for(i : 1.. hn.openClients) {
for22:					eventChan.closing!true
				}
			};
						for(i : 1.. graphUpdate.ClosedChans) {
for23:								for(i : 1.. hn.closeClients) {
for24:					eventChan.closing!true
				}
			};
			break
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					watchRequest_eventChan.closing!true
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				watchRequest_eventChan.closing!true
			:: true;
			fi;
			break
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi;
		do
		:: _ch0.in!0 -> 
			_ch0.sending?state;
			break
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
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
