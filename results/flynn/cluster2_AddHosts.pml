#define lb_for330_0  -1
#define ub_for330_1  -1
#define lb_for361_2  -1
#define ub_for361_3  -1

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
	:: true -> 
		goto stop_process
	:: true;
	fi;
loop:		do
	:: true -> 
for10:		do
		:: _ch0.in?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				goto loop
			:: true;
			fi;
			break
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:		do
		:: _ch0.in?0 -> 
			
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
				fi
			:: true -> 
				goto stop_process
			fi;
			break
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

