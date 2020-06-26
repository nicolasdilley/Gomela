
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	int i;
	chan child_nbsnewPersistingChunkSource50 = [0] of {int};
	bool state = false;
	run nbsnewPersistingChunkSource5(child_nbsnewPersistingChunkSource50);
	child_nbsnewPersistingChunkSource50?0;
	goto stop_process
stop_process:}

proctype nbsnewPersistingChunkSource5(chan child) {
	bool closed; 
	int i;
	rl.in!0;
	run Anonymous1(rl,rl);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef rl;Chandef rl) {
	bool closed; 
	int i;
	rl.in?0;
stop_process:
}
