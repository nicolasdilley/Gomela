#define lb_for553_0  -1
#define ub_for553_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan child_v1controllernewJobWatcher32 = [0] of {int};
	chan _ch0_in = [0] of {int};
	bool state = false;
	chan child_cStreamJobEvents21 = [0] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run cStreamJobEvents2(_ch0,child_cStreamJobEvents21);
	child_cStreamJobEvents21?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run v1controllernewJobWatcher3(_ch0,child_v1controllernewJobWatcher32);
	child_v1controllernewJobWatcher32?0;
	goto stop_process
stop_process:}

proctype cStreamJobEvents2(Chandef output;chan child) {
	bool closed; 
	int i;
	chan child_cStreamEvents20 = [0] of {int};
	Chandef _ch1;
	chan _ch1_in = [0] of {int};
	_ch1.in = _ch1_in;
	chan child_cStreamEvents20 = [0] of {int};
	run cStreamEvents2(_ch1,child_cStreamEvents20);
	child_cStreamEvents20?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype go_v1controllerconvertEvents2(Chandef appEvents) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		appEvents.in?0;
		
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
	od;
for10_exit:stop_process:
}
proctype cStreamEvents2(Chandef output;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for20:
		od
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype v1controllernewJobWatcher3(Chandef events;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
