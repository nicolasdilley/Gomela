#define lb_for129_0  -1
#define ub_for129_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run Anonymous0()
	od;
	run Anonymous1();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: lb_for129_0 != -1 && ub_for129_1 != -1 -> 
				for(i : lb_for129_0.. ub_for129_1) {
for11:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for11:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for11_exit:stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
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
