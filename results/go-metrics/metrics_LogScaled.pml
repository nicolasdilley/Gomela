
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_metricsLogScaledOnCue40 = [0] of {int};
	chan _ch0_in = [0] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run Anonymous0(_ch0);
	run metricsLogScaledOnCue4(_ch0,child_metricsLogScaledOnCue40);
	child_metricsLogScaledOnCue40?0
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		_ch0.in!0
	od;
stop_process:
}
proctype metricsLogScaledOnCue4(Chandef ch;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:
	od;
	child!0;
stop_process:
}
