#define lb_for253_0  -1
#define ub_for253_1  -1
#define lb_for267_2  -1
#define ub_for267_3  -1

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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous0();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
			_ch0.in!0;
			break
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
}
proctype Anonymous0() {
	bool closed; 
	int i;
	Chandef _ch0;
	chan _ch0_in = [1] of {int};
	_ch0.in = _ch0_in;
	run Anonymous0();
	do
	:: true -> 
for20:		do
		:: _ch0.in?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:stop_process:
}
