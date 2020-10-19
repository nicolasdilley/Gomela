
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example086301078/app/channel.go
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
	Chandef uc;
	Chandef sc;
	Chandef mcc;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		sc.size = 1;
		run emptyChan(sc)
	:: else -> 
		run sync_monitor(sc)
	fi;
	run Anonymous0(sc,uc,mcc);
	
	if
	:: 1 > 0 -> 
		uc.size = 1;
		run emptyChan(uc)
	:: else -> 
		run sync_monitor(uc)
	fi;
	run Anonymous1(sc,uc,mcc);
	
	if
	:: 1 > 0 -> 
		mcc.size = 1;
		run emptyChan(mcc)
	:: else -> 
		run sync_monitor(mcc)
	fi;
	run Anonymous2(sc,uc,mcc);
	
	if
	:: sc.async_rcv?0;
	:: sc.sync?0;
	fi;
	
	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	
	if
	:: uc.async_rcv?0;
	:: uc.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: mcc.async_rcv?0;
	:: mcc.sync?0;
	fi;
	
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef sc;Chandef uc;Chandef mcc) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: sc.async_send!0;
	:: sc.sync!0 -> 
		sc.sending?0
	fi;
	sc.closing!true;
stop_process:
}
proctype Anonymous1(Chandef sc;Chandef uc;Chandef mcc) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: uc.async_send!0;
	:: uc.sync!0 -> 
		uc.sending?0
	fi;
	uc.closing!true;
stop_process:
}
proctype Anonymous2(Chandef sc;Chandef uc;Chandef mcc) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: mcc.async_send!0;
	:: mcc.sync!0 -> 
		mcc.sending?0
	fi;
	mcc.closing!true;
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

