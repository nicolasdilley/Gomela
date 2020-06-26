#define lb_for97_0  -1
#define ub_for97_1  -1
#define lb_for122_2  -1
#define ub_for122_3  -1

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
	run Anonymous0(_ch0);
	_ch0.in?0;
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
			goto stop_process
		:: true;
		fi;
loop:				do
		:: true -> 
for11:			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto loop
				:: true;
				fi
			fi
		od;
for11_exit:
	od;
for10_exit:stop_process:
}
