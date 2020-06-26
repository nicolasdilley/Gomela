#define lb_for222_0  -1
#define ub_for222_1  -1
#define lb_for283_2  -1
#define ub_for283_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [10] of {int};
	chan _ch1_in = [10] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0,_ch0,gracefulCh);
	
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
		for(i : lb_for283_2.. ub_for283_3) {
for20:		do
		:: _ch1.in?0 -> 
			break
		:: true -> 
			break
		:: true -> 
			break
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od;
		

		if
		:: true;
		:: true;
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run Anonymous1(_ch1,_ch1,gracefulCh);
			do
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			od
		fi
	};
for20_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch0;Chandef gracefulCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: _ch0.in?0 -> 
			break
		:: true -> 
			goto stop_process
		od;
		

		if
		:: true;
		:: true;
		:: true -> 
			goto stop_process
		fi
	od;
for10_exit:stop_process:
}
proctype Anonymous1(Chandef _ch1;Chandef _ch1;Chandef gracefulCh) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	gracefulCh.closing!true;
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
