#define lb_for88_0  -1
#define ub_for88_1  -1
#define lb_for201_2  -1
#define ub_for201_3  -1
#define lb_for229_4  -1
#define ub_for229_5  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [1] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous0(_ch0,_ch1);
	do
	:: true -> 
for20:		do
		:: _ch0.in?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true -> 
			_ch1.closing!true;
forSelect:						do
			:: true -> 
for21:				do
				:: _ch0.in?0 -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					
					if
					:: true -> 
						goto forSelect
					:: true;
					fi;
					break
				:: true -> 
					goto forSelect;
					break
				od
			od;
for21_exit:;
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		_ch0.in!0;
		_ch0.sending?state;
		do
		:: _ch1.in?0 -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			_ch0.in!0;
			_ch0.sending?state;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				_ch0.in!0;
				_ch0.sending?state;
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				_ch0.in!0;
				_ch0.sending?state;
				goto stop_process
			:: true;
			fi
		:: true -> 
			do
			:: true -> 
for11:				
				if
				:: true -> 
					
					if
					:: true -> 
						_ch0.in!0;
						_ch0.sending?state;
						goto stop_process
					:: true;
					fi
				:: true;
				fi
			od;
			do
			:: true -> 
for12:				
				if
				:: true -> 
					break
				:: true;
				fi
			od;
			
			if
			:: true -> 
				_ch0.in!0;
				_ch0.sending?state;
				goto stop_process
			:: true;
			fi
		fi
	od;
for10_exit:	_ch0.closing!true;
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
