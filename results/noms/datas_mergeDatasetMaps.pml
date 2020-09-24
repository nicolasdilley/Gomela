#define lb_for536_0  -1
#define ub_for536_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example877977840/go/datas/remote_database_handlers.go
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
	Chandef aChangeChan;
	int i;
	int aChangeChan = 5;
	Chandef bChangeChan;
	Chandef stopChan;
	int bChangeChan = 5;
	bool state = false;
	run sync_monitor(bChangeChan);
	run sync_monitor(aChangeChan);
	run sync_monitor(stopChan);
	run Anonymous0(aChangeChan,bChangeChan,stopChan);
	run Anonymous1(aChangeChan,bChangeChan,stopChan);
	do
	:: true -> 
for30:		
		if
		:: true -> 
			
			if
			:: aChangeChan.async_rcv?0;
			:: aChangeChan.sync?0;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: bChangeChan.async_rcv?0;
			:: bChangeChan.sync?0;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			break
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
		fi
	od;
for30_exit:	goto stop_process;
	stopChan.closing!true;
	do
	:: aChangeChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			aChangeChan.in?0
		fi
	od;
	do
	:: bChangeChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			bChangeChan.in?0
		fi
	od
stop_process:}

proctype Anonymous0(Chandef aChangeChan;Chandef bChangeChan;Chandef stopChan) {
	bool closed; 
	int i;
	aChangeChan.closing!true;
stop_process:
}
proctype Anonymous1(Chandef aChangeChan;Chandef bChangeChan;Chandef stopChan) {
	bool closed; 
	int i;
	bChangeChan.closing!true;
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

