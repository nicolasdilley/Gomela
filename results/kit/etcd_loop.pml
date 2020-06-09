#define lb_for93_0  -1
#define ub_for93_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	
	if
	:: lb_for93_0 != -1 && ub_for93_1 != -1 -> 
				for(i : lb_for93_0.. ub_for93_1) {
for10:			do
			:: true -> 
				break
			:: _ch0.in?0 -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
				break
			:: _ch0.in?0 -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for10_exit:
stop_process:}

