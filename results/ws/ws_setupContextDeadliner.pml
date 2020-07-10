
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example280995754/dialer.go
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
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	run Anonymous0();
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	do
	:: true -> 
		interrupt.in!0;
		break
	:: true -> 
		interrupt.in!0;
		break
	od;
stop_process:
}
