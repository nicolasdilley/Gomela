#define lb_for167_0  -1
#define ub_for167_1  -1

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
	
	if
	:: firstPort + 1 != -1 && firstPort + blockSize-1 != -1 -> 
				for(i : firstPort + 1.. firstPort + blockSize-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	_ch0.in = _ch0_in;
	run go_freeportcheckFreedPorts1(_ch0)
stop_process:}

proctype go_freeportcheckFreedPorts1(Chandef stopCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: stopCh.in?0 -> 
			goto stop_process
		:: true -> 
			break
		od
	od;
for20_exit:stop_process:
}
