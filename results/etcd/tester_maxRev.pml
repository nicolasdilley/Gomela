#define clus_Members  5
#define clus_Members  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example391587469/functional/tester/cluster.go
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
	Chandef revc;
	Chandef errc;
	int clus_Members = 5;
	bool state = false;
	
	if
	:: clus_Members > 0 -> 
		errc.size = clus_Members;
		run emptyChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	
	if
	:: clus_Members > 0 -> 
		revc.size = clus_Members;
		run emptyChan(revc)
	:: else -> 
		run sync_monitor(revc)
	fi;
	do
	:: true -> 
for10:		run Anonymous0(revc,errc)
	:: true -> 
		break
	od;
	
	if
	:: 0 != -1 && clus_Members-1 != -1 -> 
				for(i : 0.. clus_Members-1) {
for20:			
			if
			:: errc.async_rcv?0;
			:: errc.sync?0;
			fi;
			
			if
			:: revc.async_rcv?0;
			:: revc.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: errc.async_rcv?0;
			:: errc.sync?0;
			fi;
			
			if
			:: revc.async_rcv?0;
			:: revc.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef revc;Chandef errc) {
	bool closed; 
	int i;
	
	if
	:: revc.async_send!0;
	:: revc.sync!0 -> 
		revc.sending?0
	fi;
	
	if
	:: errc.async_send!0;
	:: errc.sync!0 -> 
		errc.sending?0
	fi;
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

