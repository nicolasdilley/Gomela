#define lb_for1144_0  -1
#define ub_for1144_1  -1
#define lb_for1202_2  -1
#define ub_for1202_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [numTasks] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
		for(i : 0.. GOMAXPROCS_runtime(0)-1) {
for10:		run Anonymous0(_ch0,quitCh)
	};
for10_exit:	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous1(_ch0,_ch1);
	run Anonymous2(_ch0,_ch1);
	run Anonymous3(_ch0,_ch1);
	
	if
	:: 0 != -1 && numTasks-1 != -1 -> 
				for(i : 0.. numTasks-1) {
for40:			_ch0.in!0;
			_ch0.sending?state
		}
	:: else -> 
		do
		:: true -> 
for40:			_ch0.in!0;
			_ch0.sending?state
		:: true -> 
			break
		od
	fi;
for40_exit:	_ch0.closing!true
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef quitCh) {
	bool closed; 
	int i;
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	_ch1.closing!true;
stop_process:
}
proctype Anonymous2(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: _ch1.in?0 -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: _ch1.in?0 -> 
			goto stop_process
		:: true -> 
			break
		od;
		do
		:: true -> 
for21:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		od
	od;
for20_exit:stop_process:
}
proctype Anonymous3(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		:: _ch1.in?0 -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: _ch1.in?0 -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: 0 != -1 && len(tasks) - 1 != -1 -> 
						for(i : 0.. len(tasks) - 1) {
for31:				
				if
				:: true -> 
					break
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for31:				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for31_exit:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for30_exit:stop_process:
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
