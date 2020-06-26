#define lb_for365_0  -1
#define ub_for365_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch2;
	Chandef _ch1;
	Chandef _ch0;
		for(i : 1.. manuals) {
for10:		run Anonymous0(sent,failed,done)
	};
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
		for(i : 1.. copies) {
for20:		run Anonymous1(_ch2,_ch1,_ch0)
	};
		for(i : uint64(0).. numManualParts-1) {
for30:		run Anonymous2(_ch2,_ch1,_ch0)
	};
for30_exit:	run Anonymous3(_ch2,_ch1,_ch0);
	
	if
	:: lb_for365_0 != -1 && ub_for365_1 != -1 -> 
				for(i : lb_for365_0.. ub_for365_1) {
for40:			do
			:: _ch2.in?0 -> 
				break
			:: _ch1.in?0 -> 
				
				if
				:: true -> 
					_ch0.closing!true
				:: true;
				fi;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for40:			do
			:: _ch2.in?0 -> 
				break
			:: _ch1.in?0 -> 
				
				if
				:: true -> 
					_ch0.closing!true
				:: true;
				fi;
				break
			od
		:: true -> 
			break
		od
	fi;
for40_exit:	
	if
	:: true -> 
		_ch0.closing!true
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef sent;Chandef failed;Chandef done) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1(Chandef _ch2;Chandef _ch1;Chandef _ch0) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous2(Chandef _ch2;Chandef _ch1;Chandef _ch0) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous3(Chandef _ch2;Chandef _ch1;Chandef _ch0) {
	bool closed; 
	int i;
	_ch2.closing!true;
	_ch1.closing!true;
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
