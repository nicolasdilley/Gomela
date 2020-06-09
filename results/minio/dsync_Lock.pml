#define lb_for239_0  -1
#define ub_for239_1  -1
#define lb_for281_2  -1
#define ub_for281_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [len(restClnts)] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	do
	:: true -> 
for10:		run Anonymous0(_ch0)
	od;
	run Anonymous1(_ch0);
	goto stop_process;
	_ch0.closing!true
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		_ch0.in!0;
		_ch0.sending?state;
		goto stop_process
	:: true;
	fi;
	_ch0.in!0;
	_ch0.sending?state;
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: lb_for239_0 != -1 && ub_for239_1 != -1 -> 
				for(i : lb_for239_0.. ub_for239_1) {
for20:			do
			:: _ch0.in?0 -> 
				break
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: _ch0.in?0 -> 
				break
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: lb_for281_2 != -1 && ub_for281_3 != -1 -> 
				for(i : lb_for281_2.. ub_for281_3) {
for30:			_ch0.in?0
		}
	:: else -> 
		do
		:: true -> 
for30:			_ch0.in?0
		:: true -> 
			break
		od
	fi;
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
