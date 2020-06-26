#define lb_for340_0  -1
#define ub_for340_1  -1
#define lb_for353_2  -1
#define ub_for353_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		run Anonymous0()
	:: true;
	fi
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	
	if
	:: lb_for340_0 != -1 && ub_for340_1 != -1 -> 
				for(i : lb_for340_0.. ub_for340_1) {
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
for10_exit:	_ch0.closing!true;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: lb_for353_2 != -1 && ub_for353_3 != -1 -> 
						for(i : lb_for353_2.. ub_for353_3) {
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
	od;
stop_process:
}
proctype Anonymous0() {
	bool closed; 
	int i;
	Chandef _ch0;
	chan _ch0_in = [1] of {int};
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0();
	run Anonymous1();
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
