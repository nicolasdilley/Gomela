#define lb_for588_0  -1
#define ub_for588_1  -1
#define lb_for601_2  -1
#define ub_for601_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example966171292/kernel.go
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
	Chandef quit;
	bool state = false;
	run sync_monitor(quit);
	run Anonymous0(quit);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef quit) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true;
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
}
proctype Anonymous0(Chandef quit) {
	bool closed; 
	int i;
	Chandef msgs;
	run sync_monitor(msgs);
	run Anonymous0(quit);
	do
	:: true -> 
for20:		do
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
			goto stop_process
		:: true;
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
