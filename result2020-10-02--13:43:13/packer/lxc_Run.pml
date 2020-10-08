#define lb_for71_0  -1
#define ub_for71_1  -1
#define lb_for35_2  -1
#define ub_for35_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example730998850/builder/lxc/step_wait_init.go
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
	Chandef cancel;
	int i;
	Chandef waitDone;
	bool state = false;
	run sync_monitor(cancel);
	
	if
	:: 1 > 0 -> 
		waitDone.size = 1;
		run emptyChan(waitDone)
	:: else -> 
		run sync_monitor(waitDone)
	fi;
	run Anonymous0(cancel,waitDone);
WaitLoop:		do
	:: true -> 
for20:		do
		:: waitDone.async_rcv?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto WaitLoop;
			break
		:: waitDone.sync?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto WaitLoop;
			break
		:: true -> 
			cancel.closing!true;
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				cancel.closing!true;
				goto stop_process
			:: true;
			fi
		od
	od;
for20_exit:;
	goto stop_process
stop_process:}

proctype swaitForInit(Chandef cancel;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: cancel.async_rcv?0 -> 
			goto stop_process
		:: cancel.sync?0 -> 
			goto stop_process
		:: true;
		od;
		
		if
		:: true -> 
			break
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi
		fi
	od;
for10_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef cancel;Chandef waitDone) {
	bool closed; 
	int i;
	chan child_swaitForInit0 = [0] of {int};
	run swaitForInit(cancel,child_swaitForInit0);
	child_swaitForInit0?0;
	
	if
	:: waitDone.async_send!0;
	:: waitDone.sync!0 -> 
		waitDone.sending?0
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

