#define lb_for120_0  -1
#define ub_for120_1  -1
#define lb_for149_2  -1
#define ub_for149_3  -1
#define lb_for165_4  -1
#define ub_for165_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example253508763/registrator.go
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
	bool state = false;
	Chandef quit;
	Chandef events;
	int i;
	
	if
	:: lb_for120_0 != -1 && ub_for120_1 != -1 -> 
				for(i : lb_for120_0.. ub_for120_1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	run sync_monitor(events);
	run sync_monitor(quit);
	
	if
	:: true -> 
		run Anonymous0(events,quit)
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous1(events,quit)
	:: true;
	fi;
	do
	:: events.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: events.async_rcv?0;
			:: events.sync?0;
			fi;
			

			if
			:: true;
			:: true;
			fi
		fi
	od;
	quit.closing!true
stop_process:}

proctype Anonymous0(Chandef events;Chandef quit) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true;
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
			goto stop_process
		od
	od;
for20_exit:stop_process:
}
proctype Anonymous1(Chandef events;Chandef quit) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		:: true;
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
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

