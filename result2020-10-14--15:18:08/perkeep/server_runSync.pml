#define runSync_toCopy  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example077723975/pkg/server/sync.go
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
	Chandef enumch;
	Chandef resch;
	Chandef intr;
	int i;
	Chandef errch;
	Chandef workch;
	int toCopy = runSync_toCopy;
	bool state = false;
	
	if
	:: 8 > 0 -> 
		enumch.size = 8;
		run emptyChan(enumch)
	:: else -> 
		run sync_monitor(enumch)
	fi;
	
	if
	:: 1 > 0 -> 
		errch.size = 1;
		run emptyChan(errch)
	:: else -> 
		run sync_monitor(errch)
	fi;
	run sync_monitor(intr);
	run Anonymous0(enumch,errch,intr,workch,resch);
	
	if
	:: 1000 > 0 -> 
		workch.size = 1000;
		run emptyChan(workch)
	:: else -> 
		run sync_monitor(workch)
	fi;
	
	if
	:: 8 > 0 -> 
		resch.size = 8;
		run emptyChan(resch)
	:: else -> 
		run sync_monitor(resch)
	fi;
FeedWork:		do
	:: enumch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: enumch.async_rcv?0;
			:: enumch.sync?0;
			fi;
			
			if
			:: true -> 
				run go_shcopyWorker(resch,workch)
			:: true;
			fi;
			do
			:: workch.async_send!0 -> 
				break
			:: workch.sync!0 -> 
				workch.sending?0;
				break
			:: true -> 
				goto FeedWork;
				break
			od
		fi
	od;
	workch.closing!true;
	
	if
	:: 0 != -1 && toCopy-1 != -1 -> 
				for(i : 0.. toCopy-1) {
for20:			
			if
			:: resch.async_rcv?0;
			:: resch.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: resch.async_rcv?0;
			:: resch.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: errch.async_rcv?0;
	:: errch.sync?0;
	fi;
	goto stop_process;
	intr.closing!true
stop_process:}

proctype Anonymous0(Chandef enumch;Chandef errch;Chandef intr;Chandef workch;Chandef resch) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: errch.async_send!0;
	:: errch.sync!0 -> 
		errch.sending?0
	fi;
stop_process:
}
proctype go_shcopyWorker(Chandef res;Chandef work) {
	bool closed; 
	int i;
	bool state;
	do
	:: work.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: work.async_rcv?0;
			:: work.sync?0;
			fi;
			
			if
			:: res.async_send!0;
			:: res.sync!0 -> 
				res.sending?0
			fi
		fi
	od;
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

