#define lb_for250_0  -1
#define ub_for250_1  -1
#define lb_for82_2  -1
#define ub_for82_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	
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
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	run go_clientmessageReader4(_ch0,_ch1);
	do
	:: true -> 
for20:		do
		:: _ch0.in?0 -> 
			break
		:: true -> 
			goto stop_process
		:: _ch1.in?0 -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

proctype go_clientmessageReader4(Chandef messages;Chandef errors) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			errors.in!0;
			goto stop_process
		:: true;
		fi;
		do
		:: messages.in!0 -> 
			break
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
}
