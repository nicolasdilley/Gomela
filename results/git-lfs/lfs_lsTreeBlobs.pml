#define chanBufSize  5
#define lb_for115_1  -1
#define ub_for115_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example050201540/lfs/gitscanner_tree.go
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
	chan child_lfsNewTreeBlobChannelWrapper0 = [0] of {int};
	Chandef blobs;
	bool state = false;
	Chandef errchan;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: chanBufSize > 0 -> 
		blobs.size = chanBufSize;
		run emptyChan(blobs)
	:: else -> 
		run sync_monitor(blobs)
	fi;
	
	if
	:: 1 > 0 -> 
		errchan.size = 1;
		run emptyChan(errchan)
	:: else -> 
		run sync_monitor(errchan)
	fi;
	run Anonymous0(blobs,errchan);
	run lfsNewTreeBlobChannelWrapper(blobs,errchan,child_lfsNewTreeBlobChannelWrapper0);
	child_lfsNewTreeBlobChannelWrapper0?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef blobs;Chandef errchan) {
	bool closed; 
	int i;
	
	if
	:: lb_for115_1 != -1 && ub_for115_2 != -1 -> 
				for(i : lb_for115_1.. ub_for115_2) {
for10:			
			if
			:: true -> 
				
				if
				:: blobs.async_send!0;
				:: blobs.sync!0 -> 
					blobs.sending?0
				fi
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: blobs.async_send!0;
				:: blobs.sync!0 -> 
					blobs.sending?0
				fi
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: errchan.async_send!0;
		:: errchan.sync!0 -> 
			errchan.sending?0
		fi
	:: true;
	fi;
	blobs.closing!true;
	errchan.closing!true;
stop_process:
}
proctype lfsNewTreeBlobChannelWrapper(Chandef treeBlobChan;Chandef errorChan;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
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

