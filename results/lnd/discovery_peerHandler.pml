#define lb_for173_0  -1
#define ub_for173_1  -1
#define lb_for286_2  -1
#define ub_for286_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
waitUntilOnline:	;
out:		do
	:: true -> 
for10:		do
		:: true -> 
			break
		:: _ch0.in?0 -> 
			goto out;
			break
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:		do
		:: true -> 
			goto waitUntilOnline;
			break
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			goto waitUntilOnline
		:: true;
		fi
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		peerMgr_done.closing!true;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for30:		do
		:: true -> 
			break
		:: true -> 
			goto waitUntilOnline;
			break
		:: true -> 
			goto stop_process
		od
	od;
for30_exit:
stop_process:}

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
