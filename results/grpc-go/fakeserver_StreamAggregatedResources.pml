#define lb_for133_0  -1
#define ub_for133_1  -1
#define lb_for148_2  -1
#define ub_for148_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [2] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run Anonymous0(_ch0);
	run Anonymous1(_ch0);
	_ch0.in?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			_ch0.in!0;
			goto stop_process
		:: true;
		fi
	od;
for10_exit:stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
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
			fi;
			break
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:	_ch0.in!0;
stop_process:
}
