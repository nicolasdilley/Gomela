#define lb_for422_0  -1
#define ub_for422_1  -1
#define lb_for434_2  -1
#define ub_for434_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run Anonymous0(_ch0);
	
	if
	:: lb_for422_0 != -1 && ub_for422_1 != -1 -> 
				for(i : lb_for422_0.. ub_for422_1) {
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
for10_exit:	
	if
	:: true -> 
		
		if
		:: lb_for434_2 != -1 && ub_for434_3 != -1 -> 
						for(i : lb_for434_2.. ub_for434_3) {
for20:
			}
		:: else -> 
			do
			:: true -> 
for20:
			:: true -> 
				break
			od
		fi;
for20_exit:
	:: true;
	fi;
	_ch0.in!0
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
		break
	:: _ch0.in?0 -> 
		break
	od;
stop_process:
}
