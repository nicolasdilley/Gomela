
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	int i;
	chan child_iotoolNewTimeoutWriterFromChan20 = [0] of {int};
	bool state = false;
	run iotoolNewTimeoutWriterFromChan2(child_iotoolNewTimeoutWriterFromChan20);
	child_iotoolNewTimeoutWriterFromChan20?0;
	goto stop_process
stop_process:}

proctype iotoolNewTimeoutWriterFromChan2(chan child) {
	bool closed; 
	int i;
	run Anonymous1(done,done);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef done;Chandef done) {
	bool closed; 
	int i;
	done.in?0;
stop_process:
}
