#define lb_for1139_0  -1
#define ub_for1139_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [c.Nodes] of {int};
	chan _ch1_in = [c.Nodes] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		od
	fi;
	do
	:: true -> 
for20:		run Anonymous0(_ch0,_ch1)
	od;
	run Anonymous1(_ch0,_ch1);
	
	if
	:: lb_for1139_0 != -1 && ub_for1139_1 != -1 -> 
				for(i : lb_for1139_0.. ub_for1139_1) {
for30:			do
			:: true -> 
				break
			:: _ch0.in?0 -> 
				break
			od;
			
			if
			:: true -> 
				do
				:: true -> 
for31:
				od
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			do
			:: true -> 
				break
			:: _ch0.in?0 -> 
				break
			od;
			
			if
			:: true -> 
				do
				:: true -> 
for31:
				od
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: true -> 
		do
		:: true -> 
for40:
		od
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			_ch0.in!0;
			_ch0.sending?state;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			_ch0.in!0;
			_ch0.sending?state;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			_ch0.in!0;
			_ch0.sending?state;
			goto stop_process
		:: true;
		fi;
		_ch0.in!0;
		_ch0.sending?state;
		goto stop_process
	:: true;
	fi;
	_ch1.in?0;
	
	if
	:: true -> 
		_ch0.in!0;
		_ch0.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		_ch0.in!0;
		_ch0.sending?state;
		goto stop_process
	:: true;
	fi;
	_ch0.in!0;
	_ch0.sending?state;
	
	if
	:: true -> 
		
		if
		:: 0 != -1 && treeDistFanout-1 != -1 -> 
						for(i : 0.. treeDistFanout-1) {
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
for21_exit:
	fi;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1) {
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
