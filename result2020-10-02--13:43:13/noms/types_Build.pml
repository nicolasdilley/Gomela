#define lb_for138_0  -1
#define ub_for138_1  -1
#define lb_for163_2  -1
#define ub_for163_3  -1
#define lb_for175_4  -1
#define ub_for175_5  -1
#define lb_for187_6  -1
#define ub_for187_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example068066955/go/types/graph_builder.go
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
	Chandef graphOpChan;
	bool state = false;
	
	if
	:: 512 > 0 -> 
		graphOpChan.size = 512;
		run emptyChan(graphOpChan)
	:: else -> 
		run sync_monitor(graphOpChan)
	fi;
	run Anonymous0(graphOpChan);
	do
	:: graphOpChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: graphOpChan.async_rcv?0;
			:: graphOpChan.sync?0;
			fi;
			
			if
			:: lb_for163_2 != -1 && ub_for163_3 != -1 -> 
								for(i : lb_for163_2.. ub_for163_3) {
for21:
				}
			:: else -> 
				do
				:: true -> 
for21:
				:: true -> 
					break
				od
			fi;
for21_exit:			
			if
			:: lb_for175_4 != -1 && ub_for175_5 != -1 -> 
								for(i : lb_for175_4.. ub_for175_5) {
for22:
				}
			:: else -> 
				do
				:: true -> 
for22:
				:: true -> 
					break
				od
			fi;
for22_exit:
		fi
	od;
	
	if
	:: lb_for187_6 != -1 && ub_for187_7 != -1 -> 
				for(i : lb_for187_6.. ub_for187_7) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef graphOpChan) {
	bool closed; 
	int i;
	
	if
	:: lb_for138_0 != -1 && ub_for138_1 != -1 -> 
				for(i : lb_for138_0.. ub_for138_1) {
for10:			
			if
			:: graphOpChan.async_send!0;
			:: graphOpChan.sync!0 -> 
				graphOpChan.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: graphOpChan.async_send!0;
			:: graphOpChan.sync!0 -> 
				graphOpChan.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	graphOpChan.closing!true;
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

