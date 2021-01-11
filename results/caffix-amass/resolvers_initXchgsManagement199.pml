
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example136917770/resolvers/resolver_state.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef xchgsChs_PullRequest;
	Chandef xchgsChs_AddRequest;
	Chandef xchgsChs_AllTimeoutIDs;
	Chandef xchgsChs_UpdateTimeout;
	Chandef xchgsChs_DelTimeout;
	Chandef xchgsChs_AddTimeout;
	Chandef xchgsChs_GetID;
	Chandef xchgsChs_Done;
	bool state = false;
	int i;
	

	if
	:: 2 > 0 -> 
		xchgsChs_Done.size = 2;
		run AsyncChan(xchgsChs_Done)
	:: else -> 
		run sync_monitor(xchgsChs_Done)
	fi;
	

	if
	:: 10 > 0 -> 
		xchgsChs_GetID.size = 10;
		run AsyncChan(xchgsChs_GetID)
	:: else -> 
		run sync_monitor(xchgsChs_GetID)
	fi;
	

	if
	:: 10 > 0 -> 
		xchgsChs_AddTimeout.size = 10;
		run AsyncChan(xchgsChs_AddTimeout)
	:: else -> 
		run sync_monitor(xchgsChs_AddTimeout)
	fi;
	

	if
	:: 10 > 0 -> 
		xchgsChs_DelTimeout.size = 10;
		run AsyncChan(xchgsChs_DelTimeout)
	:: else -> 
		run sync_monitor(xchgsChs_DelTimeout)
	fi;
	

	if
	:: 10 > 0 -> 
		xchgsChs_UpdateTimeout.size = 10;
		run AsyncChan(xchgsChs_UpdateTimeout)
	:: else -> 
		run sync_monitor(xchgsChs_UpdateTimeout)
	fi;
	

	if
	:: 10 > 0 -> 
		xchgsChs_AllTimeoutIDs.size = 10;
		run AsyncChan(xchgsChs_AllTimeoutIDs)
	:: else -> 
		run sync_monitor(xchgsChs_AllTimeoutIDs)
	fi;
	

	if
	:: 10 > 0 -> 
		xchgsChs_AddRequest.size = 10;
		run AsyncChan(xchgsChs_AddRequest)
	:: else -> 
		run sync_monitor(xchgsChs_AddRequest)
	fi;
	

	if
	:: 10 > 0 -> 
		xchgsChs_PullRequest.size = 10;
		run AsyncChan(xchgsChs_PullRequest)
	:: else -> 
		run sync_monitor(xchgsChs_PullRequest)
	fi;
	goto stop_process
stop_process:skip
}

proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

