#define lb_for279_0  -1
#define ub_for279_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example730998850/packer/plugin/client.go
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
	Chandef linesCh;
	Chandef c_doneLogging;
	bool state = false;
	Chandef exitCh;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(c_doneLogging);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(exitCh);
	run Anonymous0(c_doneLogging,exitCh,linesCh);
	run sync_monitor(linesCh);
	run Anonymous1(c_doneLogging,exitCh,linesCh);
	do
	:: true;
	:: exitCh.async_rcv?0 -> 
		break
	:: exitCh.sync?0 -> 
		break
	od;
	goto stop_process;
	run Anonymous2(c_doneLogging,exitCh,linesCh)
stop_process:}

proctype Anonymous0(Chandef c_doneLogging;Chandef exitCh;Chandef linesCh) {
	bool closed; 
	int i;
	exitCh.closing!true;
stop_process:
}
proctype Anonymous1(Chandef c_doneLogging;Chandef exitCh;Chandef linesCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: linesCh.async_send!0;
			:: linesCh.sync!0 -> 
				linesCh.sending?0
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for10_exit:	linesCh.closing!true;
stop_process:
}
proctype Anonymous2(Chandef c_doneLogging;Chandef exitCh;Chandef linesCh) {
	bool closed; 
	int i;
	do
	:: linesCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: linesCh.async_rcv?0;
			:: linesCh.sync?0;
			fi
		fi
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

