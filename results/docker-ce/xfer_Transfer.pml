#define lb_for317_0  -1
#define ub_for317_1  -1
#define lb_for99_2  -1
#define ub_for99_3  -1
#define lb_for364_4  -1
#define ub_for364_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example076315280/components/engine/distribution/xfer/transfer.go
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
	Chandef mainProgressChan;
	Chandef start;
	bool state = false;
	Chandef inactive;
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			break
		:: true;
		fi;
		do
		:: true;
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:	run sync_monitor(start);
	run sync_monitor(inactive);
	
	if
	:: true -> 
		start.closing!true
	fi;
	run sync_monitor(mainProgressChan);
	run go_xferBroadcast(mainProgressChan);
	run Anonymous1(start,inactive,mainProgressChan);
	goto stop_process
stop_process:}

proctype go_xferBroadcast(Chandef mainProgressChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true -> 
			do
			:: true;
			od;
			break
		od;
		
		if
		:: true -> 
			do
			:: true -> 
for21:				do
				:: true;
				:: true -> 
					break
				od
			:: true -> 
				break
			od
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for20_exit:stop_process:
}
proctype tminactivate(Chandef start;chan child) {
	bool closed; 
	int i;
	do
	:: start.async_rcv?0 -> 
		break
	:: start.sync?0 -> 
		break
	:: true -> 
		break
	od;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef start;Chandef inactive;Chandef mainProgressChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		:: inactive.async_rcv?0 -> 
			chan child_tminactivate0 = [0] of {int};
			run tminactivate(start,child_tminactivate0);
			child_tminactivate0?0;
			break
		:: inactive.sync?0 -> 
			chan child_tminactivate0 = [0] of {int};
			run tminactivate(start,child_tminactivate0);
			child_tminactivate0?0;
			break
		:: true -> 
			
			if
			:: true -> 
				chan child_tminactivate1 = [0] of {int};
				run tminactivate(start,child_tminactivate1);
				child_tminactivate1?0
			:: true;
			fi;
			goto stop_process
		od
	od;
for30_exit:stop_process:
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

