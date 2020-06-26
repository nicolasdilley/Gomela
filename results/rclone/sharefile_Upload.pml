#define lb_for186_0  -1
#define ub_for186_1  -1

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
outer:			for(i : lb_for186_0.. ub_for186_1) {
for10:		do
		:: true -> 
			goto outer;
			break
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto outer
			:: true;
			fi
		fi
	};
for10_exit:;
	
	if
	:: true -> 
		do
		:: true -> 
			break
		:: true -> 
			break
		od
	:: true;
	fi;
	goto stop_process
stop_process:}

