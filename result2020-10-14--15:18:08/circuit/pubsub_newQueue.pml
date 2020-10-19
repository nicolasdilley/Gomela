#define lb_for199_0  -1
#define ub_for199_1  -1
#define lb_for224_2  -1
#define ub_for224_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example791829180/kit/pubsub/pubsub.go
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
	Chandef ch1;
	int i;
	Chandef ch2;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		ch1.size = 1;
		run emptyChan(ch1)
	:: else -> 
		run sync_monitor(ch1)
	fi;
	
	if
	:: 1 > 0 -> 
		ch2.size = 1;
		run emptyChan(ch2)
	:: else -> 
		run sync_monitor(ch2)
	fi;
	run go_qloop(ch1,ch2);
	goto stop_process
stop_process:}

proctype go_qloop(Chandef ch1;Chandef ch2) {
	bool closed; 
	int i;
	bool state;
__preclose:		do
	:: true -> 
for10:		
		if
		:: true -> 
			do
			:: ch1.async_rcv?0 -> 
				
				if
				:: true -> 
					goto __preclose
				:: true;
				fi;
				break
			:: ch1.sync?0 -> 
				
				if
				:: true -> 
					goto __preclose
				:: true;
				fi;
				break
			:: ch2.async_send!0 -> 
				break
			:: ch2.sync!0 -> 
				ch2.sending?0;
				break
			od
		:: true -> 
			
			if
			:: ch1.async_rcv?0;
			:: ch1.sync?0;
			fi;
			
			if
			:: true -> 
				goto __preclose
			:: true;
			fi
		:: true -> 
			
			if
			:: ch1.async_rcv?0;
			:: ch1.sync?0;
			fi;
			
			if
			:: true -> 
				goto __preclose
			:: true;
			fi
		fi
	od;
for10_exit:;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			ch2.closing!true;
			goto stop_process
		:: true;
		fi;
		
		if
		:: ch2.async_send!0;
		:: ch2.sync!0 -> 
			ch2.sending?0
		fi
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

