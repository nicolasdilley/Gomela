#define stores  ??
#define lb_for1312_1  -1
#define ub_for1312_2  -1
#define lb_for1331_3  -1
#define ub_for1331_4  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [stores] of {int};
	chan _ch1_in = [stores] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
		for(i : 1.. stores) {
for10:		run Anonymous0(_ch0,_ch1)
	};
	do
	:: true -> 
for20:		
		if
		:: true -> 
			break
		:: true;
		fi;
		do
		:: _ch0.in!0 -> 
			_ch0.sending?state;
			break
		:: _ch1.in?0 -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:	_ch0.closing!true;
	do
	:: _ch1.in?0 -> 
		goto stop_process
	:: true -> 
		break
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		do
		:: _ch0.in?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				_ch1.in!0;
				_ch1.sending?state
			:: true;
			fi;
			break
		:: true -> 
			goto stop_process
		od
	od;
for11_exit:stop_process:
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
