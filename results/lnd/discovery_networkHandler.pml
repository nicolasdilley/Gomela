#define lb_for911_0  -1
#define ub_for911_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	int i;
	chan child_routingNewValidationBarrier20 = [0] of {int};
	bool state = false;
	run routingNewValidationBarrier2(NumCPU_runtime() * 4,child_routingNewValidationBarrier20);
	child_routingNewValidationBarrier20?0;
		for(i : lb_for911_0.. ub_for911_1) {
for20:		do
		:: true -> 
			policyUpdate_errChan.in!0;
			break
		:: true -> 
			
			if
			:: true -> 
				announcement_err.in!0
			:: true;
			fi;
			run Anonymous1();
			break
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for21:
			od;
			break
		:: true -> 
			run Anonymous2();
			break
		:: true -> 
			break
		:: true -> 
			goto stop_process
		od
	};
for20_exit:
stop_process:}

proctype routingNewValidationBarrier2(int numActiveReqs _1;chan child) {
	bool closed; 
	int i;
	Chandef _ch0;
	chan _ch0_in = [numActiveReqs _1] of {int};
	_ch0.in = _ch0_in;
	
	if
	:: 0 != -1 && numActiveReqs _1-1 != -1 -> 
				for(i : 0.. numActiveReqs _1-1) {
for10:			_ch0.in!0
		}
	:: else -> 
		do
		:: true -> 
for10:			_ch0.in!0
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
	
	if
	:: true -> 
		announcement_err.in!0;
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype Anonymous2() {
	bool closed; 
	int i;
	do
	:: true -> 
for22:		do
		:: true -> 
			break
		:: true -> 
			goto stop_process
		od
	od;
stop_process:
}
