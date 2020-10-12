
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example375454290/blocks/blockstoreutil/remove.go
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
	Chandef out;
	int i;
	int stillOkay = 5;
	bool state = false;
	
	if
	:: cids > 0 -> 
		out.size = cids;
		run emptyChan(out)
	:: else -> 
		run sync_monitor(out)
	fi;
	run Anonymous0(out);
	goto stop_process
stop_process:}

proctype blockstoreutilFilterPinned(Chandef out;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: out.async_send!0;
		:: out.sync!0 -> 
			out.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: out.async_send!0;
			:: out.sync!0 -> 
				out.sending?0
			fi
		:: true -> 
			
			if
			:: out.async_send!0;
			:: out.sync!0 -> 
				out.sending?0
			fi
		fi
	:: true -> 
		break
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef out) {
	bool closed; 
	int i;
	chan child_blockstoreutilFilterPinned0 = [0] of {int};
	run blockstoreutilFilterPinned(out,child_blockstoreutilFilterPinned0);
	child_blockstoreutilFilterPinned0?0;
		for(i : 1.. stillOkay) {
for20:		
		if
		:: true -> 
			
			if
			:: out.async_send!0;
			:: out.sync!0 -> 
				out.sending?0
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: out.async_send!0;
			:: out.sync!0 -> 
				out.sending?0
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: out.async_send!0;
			:: out.sync!0 -> 
				out.sending?0
			fi
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: out.async_send!0;
				:: out.sync!0 -> 
					out.sending?0
				fi
			:: true;
			fi
		fi
	};
	out.closing!true;
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
