#define unlimitedAllocators  ??

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_colexecnewHashRouterWithOutputs70 = [0] of {int};
	chan _ch0_in = [2 * len(unlimitedAllocators)] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for10:
	od;
	run colexecnewHashRouterWithOutputs7(_ch0,child_colexecnewHashRouterWithOutputs70);
	child_colexecnewHashRouterWithOutputs70?0;
	goto stop_process
stop_process:}

proctype colexecnewHashRouterWithOutputs7(Chandef unblockEventsChan;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:
	od;
	goto stop_process;
	child!0;
stop_process:
}
