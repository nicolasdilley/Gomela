#define lb_for83_0  -1
#define ub_for83_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example822197482/fs/asyncreader/asyncreader.go
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
	Chandef a_exit;
	Chandef a_ready;
	int i;
	Chandef a_token;
	Chandef a_exited;
	bool state = false;
	
	if
	:: buffers > 0 -> 
		a_ready.size = buffers;
		run emptyChan(a_ready)
	:: else -> 
		run sync_monitor(a_ready)
	fi;
	
	if
	:: buffers > 0 -> 
		a_token.size = buffers;
		run emptyChan(a_token)
	:: else -> 
		run sync_monitor(a_token)
	fi;
	
	if
	:: 0 > 0 -> 
		a_exit.size = 0;
		run emptyChan(a_exit)
	:: else -> 
		run sync_monitor(a_exit)
	fi;
	
	if
	:: 0 > 0 -> 
		a_exited.size = 0;
		run emptyChan(a_exited)
	:: else -> 
		run sync_monitor(a_exited)
	fi;
	
	if
	:: 0 != -1 && buffers-1 != -1 -> 
				for(i : 0.. buffers-1) {
for10:			
			if
			:: a_token.async_send!0;
			:: a_token.sync!0 -> 
				a_token.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: a_token.async_send!0;
			:: a_token.sync!0 -> 
				a_token.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	run Anonymous0(a_ready,a_token,a_exit,a_exited)
stop_process:}

proctype Anonymous0(Chandef a_ready;Chandef a_token;Chandef a_exit;Chandef a_exited) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:stop_process:
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

