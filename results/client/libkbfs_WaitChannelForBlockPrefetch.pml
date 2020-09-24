#define lb_for1738_0  -1
#define ub_for1738_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131909709/go/kbfs/libkbfs/prefetcher.go
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
	int i;
	Chandef c;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		c.size = 1;
		run emptyChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
	do
	:: true;
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	
	if
	:: true -> 
		chan child_pproxyWaitCh0 = [0] of {int};
		run pproxyWaitCh(c,child_pproxyWaitCh0);
		child_pproxyWaitCh0?0;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		do
		:: true -> 
			
			if
			:: true -> 
				chan child_pproxyWaitCh1 = [0] of {int};
				run pproxyWaitCh(c,child_pproxyWaitCh1);
				child_pproxyWaitCh1?0;
				goto stop_process
			:: true;
			fi
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:
stop_process:}

proctype pproxyWaitCh(Chandef c;chan child) {
	bool closed; 
	int i;
	Chandef proxyCh;
	run sync_monitor(proxyCh);
	run Anonymous1(proxyCh,c);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef proxyCh;Chandef c) {
	bool closed; 
	int i;
	do
	:: true -> 
		goto stop_process
	od;
	do
	:: true -> 
		proxyCh.closing!true
	:: true;
	od;
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

