#define lb_for76_0  -1
#define ub_for76_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan child_processWaitForEvent30 = [0] of {int};
	chan _ch1_in = [10] of {int};
	bool state = false;
	chan _ch0_in = [1024] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	run processWaitForEvent3(_ch1,child_processWaitForEvent30);
	child_processWaitForEvent30?0;
		for(i : lb_for76_0.. ub_for76_1) {
for10:		do
		:: _ch0.in?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			:: true;
			:: true;
			:: true -> 
				goto stop_process
			:: true;
			:: true;
			fi;
			break
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: _ch1.in?0 -> 
			
			if
			:: true -> 
				goto stop_process
			fi;
			break
		od
	};
for10_exit:
stop_process:}

proctype processWaitForEvent3(Chandef eventC;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	child!0;
stop_process:
}
