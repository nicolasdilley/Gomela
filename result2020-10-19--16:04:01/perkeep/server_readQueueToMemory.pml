#define lb_for547_0  -1
#define ub_for547_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example950889170/pkg/server/sync.go
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
	Chandef blobs;
	Chandef errc;
	Chandef intr;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		errc.size = 1;
		run emptyChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	
	if
	:: 16 > 0 -> 
		blobs.size = 16;
		run emptyChan(blobs)
	:: else -> 
		run sync_monitor(blobs)
	fi;
	run sync_monitor(intr);
	run Anonymous0(errc,blobs,intr);
	do
	:: blobs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: blobs.async_rcv?0;
			:: blobs.sync?0;
			fi
		fi
	od;
	
	if
	:: errc.async_rcv?0;
	:: errc.sync?0;
	fi;
	goto stop_process;
	intr.closing!true
stop_process:}

proctype shenumerateQueuedBlobs(Chandef dst;Chandef intr;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for547_0 != -1 && ub_for547_1 != -1 -> 
				for(i : lb_for547_0.. ub_for547_1) {
for10:			do
			:: dst.async_send!0 -> 
				break
			:: dst.sync!0 -> 
				dst.sending?0;
				break
			:: intr.async_rcv?0 -> 
				goto stop_process
			:: intr.sync?0 -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: dst.async_send!0 -> 
				break
			:: dst.sync!0 -> 
				dst.sending?0;
				break
			:: intr.async_rcv?0 -> 
				goto stop_process
			:: intr.sync?0 -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process;
	dst.closing!true;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef errc;Chandef blobs;Chandef intr) {
	bool closed; 
	int i;
	bool state;
	chan child_shenumerateQueuedBlobs0 = [0] of {int};
	run shenumerateQueuedBlobs(blobs,intr,child_shenumerateQueuedBlobs0);
	child_shenumerateQueuedBlobs0?0;
	
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

