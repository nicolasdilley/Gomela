#define lb_for70_0  -1
#define ub_for70_1  -1
#define lb_for103_2  -1
#define ub_for103_3  -1

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
	run Anonymous0(_ch0)
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
		for(i : lb_for70_0.. ub_for70_1) {
for10:		do
		:: true -> 
			break
		:: true -> 
			do
			:: true -> 
for11:				run Anonymous0(_ch0)
			od;
			break
		:: true -> 
			break
		:: _ch0.in?0 -> 
			_ch0.closing!true;
			goto stop_process
		:: true -> 
			
			if
			:: lb_for103_2 != -1 && ub_for103_3 != -1 -> 
								for(i : lb_for103_2.. ub_for103_3) {
for12:					do
					:: true -> 
						break
					:: true -> 
						break
					od
				}
			:: else -> 
				do
				:: true -> 
for12:					do
					:: true -> 
						break
					:: true -> 
						break
					od
				:: true -> 
					break
				od
			fi;
for12_exit:			do
			:: true -> 
for13:
			od;
			break
		od
	};
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
