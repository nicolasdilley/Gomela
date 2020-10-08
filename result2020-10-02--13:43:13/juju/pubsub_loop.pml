#define lb_for351_0  -1
#define ub_for351_1  -1
#define lb_for271_2  -1
#define ub_for271_3  -1
#define lb_for301_4  -1
#define ub_for301_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example529324227/worker/pubsub/remoteserver.go
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
	Chandef messageToSend;
	int i;
	Chandef messageSent;
	bool state = false;
	run sync_monitor(messageToSend);
	run sync_monitor(messageSent);
	run go_rforwardMessages(messageToSend,messageSent);
	do
	:: true -> 
for20:		do
		:: true -> 
			goto stop_process
		:: true;
		:: true;
		od;
		chan child_rsendPendingMessages0 = [0] of {int};
		run rsendPendingMessages(messageToSend,messageSent,child_rsendPendingMessages0);
		child_rsendPendingMessages0?0
	od;
for20_exit:
stop_process:}

proctype go_rforwardMessages(Chandef messageToSend;Chandef messageSent) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		od;
		do
		:: true -> 
			goto stop_process
		:: messageSent.async_send!0 -> 
			break
		:: messageSent.sync!0 -> 
			messageSent.sending?0;
			break
		od
	od;
for10_exit:stop_process:
}
proctype rsendPendingMessages(Chandef messageToSend;Chandef messageSent;chan child) {
	bool closed; 
	int i;
	
	if
	:: lb_for301_4 != -1 && ub_for301_5 != -1 -> 
				for(i : lb_for301_4.. ub_for301_5) {
for21:			do
			:: true -> 
				goto stop_process
			:: messageToSend.async_send!0 -> 
				break
			:: messageToSend.sync!0 -> 
				messageToSend.sending?0;
				break
			od;
			do
			:: true -> 
				goto stop_process
			:: messageSent.async_rcv?0 -> 
				break
			:: messageSent.sync?0 -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for21:			do
			:: true -> 
				goto stop_process
			:: messageToSend.async_send!0 -> 
				break
			:: messageToSend.sync!0 -> 
				messageToSend.sending?0;
				break
			od;
			do
			:: true -> 
				goto stop_process
			:: messageSent.async_rcv?0 -> 
				break
			:: messageSent.sync?0 -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for21_exit:	child!0;
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

