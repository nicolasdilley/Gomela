#define lb_for210_0  -1
#define ub_for210_1  -1
#define lb_for226_2  -1
#define ub_for226_3  -1
#define lb_for229_4  -1
#define ub_for229_5  -1
#define lb_for235_6  -1
#define ub_for235_7  -1
#define lb_for248_8  -1
#define ub_for248_9  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example856946014/store/store.go
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
	Chandef ops;
	Chandef st_cleanCh;
	Chandef watches;
	int i;
	Chandef seqns;
	Chandef st_watchCh;
	Chandef st_flush;
	bool state = false;
	run sync_monitor(ops);
	run sync_monitor(seqns);
	run sync_monitor(watches);
	run sync_monitor(st_watchCh);
	run sync_monitor(st_cleanCh);
	run sync_monitor(st_flush);
	run go_stprocess(ops,seqns,watches);
	goto stop_process
stop_process:}

proctype go_stprocess(Chandef ops;Chandef seqns;Chandef watches) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: seqns.async_send!0 -> 
			break
		:: seqns.sync!0 -> 
			seqns.sending?0;
			break
		:: watches.async_send!0 -> 
			break
		:: watches.sync!0 -> 
			watches.sending?0;
			break
		od;
		
		if
		:: lb_for248_8 != -1 && ub_for248_9 != -1 -> 
						for(i : lb_for248_8.. ub_for248_9) {
for14:				
				if
				:: true -> 
					break
				:: true;
				fi
			}
		:: else -> 
			do
			:: true -> 
for14:				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				break
			od
		fi;
for14_exit:
	od;
for10_exit:stop_process:
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

