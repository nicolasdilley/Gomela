#define count  ??
#define lb_for1673_1  -1
#define ub_for1673_2  -1
#define lb_for1703_3  -1
#define ub_for1703_4  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [count] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	
	if
	:: lb_for1673_1 != -1 && ub_for1673_2 != -1 -> 
				for(i : lb_for1673_1.. ub_for1673_2) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	run Anonymous0(_ch0);
	
	if
	:: lb_for1703_3 != -1 && ub_for1703_4 != -1 -> 
				for(i : lb_for1703_3.. ub_for1703_4) {
for20:			do
			:: true -> 
				break
			:: _ch0.in?0 -> 
				break
			od;
			
			if
			:: true -> 
				do
				:: true -> 
for21:
				od
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
				break
			:: _ch0.in?0 -> 
				break
			od;
			
			if
			:: true -> 
				do
				:: true -> 
for21:
				od
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: true -> 
		do
		:: true -> 
for30:
		od
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.closing!true;
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
