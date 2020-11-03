#define lb_for364_0  -1
#define ub_for364_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example906491796/aws/credentials/processcreds/provider.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	bool state = false;
	Chandef execCh;
	Chandef stdoutCh;
	int i;
	
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
	:: 1 > 0 -> 
		stdoutCh.size = 1;
		run emptyChan(stdoutCh)
	:: else -> 
		run sync_monitor(stdoutCh)
	fi;
	run go_processcredsreadInput(stdoutCh);
	
	if
	:: 1 > 0 -> 
		execCh.size = 1;
		run emptyChan(execCh)
	:: else -> 
		run sync_monitor(execCh)
	fi;
	run go_processcredsexecuteCommand(execCh);
	
	if
	:: lb_for364_0 != -1 && ub_for364_1 != -1 -> 
				for(i : lb_for364_0.. ub_for364_1) {
for10:			do
			:: stdoutCh.async_rcv?0 -> 
				break
			:: stdoutCh.sync?0 -> 
				break
			:: execCh.async_rcv?0 -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: execCh.sync?0 -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: stdoutCh.async_rcv?0 -> 
				break
			:: stdoutCh.sync?0 -> 
				break
			:: execCh.async_rcv?0 -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: execCh.sync?0 -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

proctype go_processcredsreadInput(Chandef read) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: read.async_send!0;
	:: read.sync!0 -> 
		read.sending?0
	fi;
stop_process:
}
proctype go_processcredsexecuteCommand(Chandef exec) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: exec.async_send!0;
	:: exec.sync!0 -> 
		exec.sending?0
	fi;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

