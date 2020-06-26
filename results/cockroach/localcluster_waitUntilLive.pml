#define lb_for701_0  -1
#define ub_for701_1  -1

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
	_ch0.in = _ch0_in;
	
	if
	:: lb_for701_0 != -1 && ub_for701_1 != -1 -> 
				for(i : lb_for701_0.. ub_for701_1) {
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

