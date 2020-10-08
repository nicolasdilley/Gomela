#define lb_for54_0  -1
#define ub_for54_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example068066955/go/merge/three_way_list.go
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
	Chandef bSpliceChan;
	chan child_mergestopAndDrain0 = [0] of {int};
	Chandef bStopChan;
	int i;
	Chandef aSpliceChan;
	Chandef aStopChan;
	chan child_mergestopAndDrain1 = [0] of {int};
	bool state = false;
	run sync_monitor(bSpliceChan);
	run sync_monitor(aSpliceChan);
	
	if
	:: 1 > 0 -> 
		bStopChan.size = 1;
		run emptyChan(bStopChan)
	:: else -> 
		run sync_monitor(bStopChan)
	fi;
	
	if
	:: 1 > 0 -> 
		aStopChan.size = 1;
		run emptyChan(aStopChan)
	:: else -> 
		run sync_monitor(aStopChan)
	fi;
	run Anonymous0(aSpliceChan,bSpliceChan,aStopChan,bStopChan);
	run Anonymous1(aSpliceChan,bSpliceChan,aStopChan,bStopChan);
	do
	:: true -> 
for20:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for20_exit:	goto stop_process;
	run mergestopAndDrain(aStopChan,aSpliceChan,child_mergestopAndDrain0);
	child_mergestopAndDrain0?0;
	run mergestopAndDrain(bStopChan,bSpliceChan,child_mergestopAndDrain1);
	child_mergestopAndDrain1?0
stop_process:}

proctype Anonymous0(Chandef aSpliceChan;Chandef bSpliceChan;Chandef aStopChan;Chandef bStopChan) {
	bool closed; 
	int i;
	aSpliceChan.closing!true;
stop_process:
}
proctype Anonymous1(Chandef aSpliceChan;Chandef bSpliceChan;Chandef aStopChan;Chandef bStopChan) {
	bool closed; 
	int i;
	bSpliceChan.closing!true;
stop_process:
}
proctype mergestopAndDrain(Chandef stop;Chandef drain;chan child) {
	bool closed; 
	int i;
	stop.closing!true;
	do
	:: drain.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: drain.async_rcv?0;
			:: drain.sync?0;
			fi
		fi
	od;
	child!0;
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

