
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example510331850/weed/stats/stats.go
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
	Chandef Chan_BytesOut;
	Chandef Chan_BytesIn;
	Chandef Chan_DeleteRequests;
	Chandef Chan_WriteRequests;
	Chandef Chan_ReadRequests;
	Chandef Chan_AssignRequests;
	Chandef Chan_Requests;
	Chandef Chan_Connections;
	bool state = false;
	int i;
	

	if
	:: 100 > 0 -> 
		Chan_Connections.size = 100;
		run AsyncChan(Chan_Connections)
	:: else -> 
		run sync_monitor(Chan_Connections)
	fi;
	

	if
	:: 100 > 0 -> 
		Chan_Requests.size = 100;
		run AsyncChan(Chan_Requests)
	:: else -> 
		run sync_monitor(Chan_Requests)
	fi;
	

	if
	:: 100 > 0 -> 
		Chan_AssignRequests.size = 100;
		run AsyncChan(Chan_AssignRequests)
	:: else -> 
		run sync_monitor(Chan_AssignRequests)
	fi;
	

	if
	:: 100 > 0 -> 
		Chan_ReadRequests.size = 100;
		run AsyncChan(Chan_ReadRequests)
	:: else -> 
		run sync_monitor(Chan_ReadRequests)
	fi;
	

	if
	:: 100 > 0 -> 
		Chan_WriteRequests.size = 100;
		run AsyncChan(Chan_WriteRequests)
	:: else -> 
		run sync_monitor(Chan_WriteRequests)
	fi;
	

	if
	:: 100 > 0 -> 
		Chan_DeleteRequests.size = 100;
		run AsyncChan(Chan_DeleteRequests)
	:: else -> 
		run sync_monitor(Chan_DeleteRequests)
	fi;
	

	if
	:: 100 > 0 -> 
		Chan_BytesIn.size = 100;
		run AsyncChan(Chan_BytesIn)
	:: else -> 
		run sync_monitor(Chan_BytesIn)
	fi;
	

	if
	:: 100 > 0 -> 
		Chan_BytesOut.size = 100;
		run AsyncChan(Chan_BytesOut)
	:: else -> 
		run sync_monitor(Chan_BytesOut)
	fi
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

