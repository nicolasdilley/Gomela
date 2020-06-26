#define lb_for255_0  -1
#define ub_for255_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [1] of {int};
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
waitloop:		do
	:: true -> 
for10:		do
		:: true -> 
			goto waitloop;
			break
		:: _ch0.in?0 -> 
			goto waitloop;
			break
		:: _ch1.in?0 -> 
			break
		od
	od;
for10_exit:;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

