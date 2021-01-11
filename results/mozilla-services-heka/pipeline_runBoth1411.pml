
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example976469541/pipeline/plugin_runners.go
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
	Chandef foRunner_inChan;
	Chandef foRunner_stopChan;
	Chandef bufErrChan;
	Chandef pluginErrChan;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		pluginErrChan.size = 1;
		run AsyncChan(pluginErrChan)
	:: else -> 
		run sync_monitor(pluginErrChan)
	fi;
	

	if
	:: 1 > 0 -> 
		bufErrChan.size = 1;
		run AsyncChan(bufErrChan)
	:: else -> 
		run sync_monitor(bufErrChan)
	fi;
	do
	:: pluginErrChan.async_rcv?0 -> 
		break
	:: pluginErrChan.sync?0 -> 
		break
	:: bufErrChan.async_rcv?0 -> 
		break
	:: bufErrChan.sync?0 -> 
		break
	od;
	

	if
	:: true -> 
		

		if
		:: 2 > 0 -> 
			foRunner_inChan.size = 2;
			run AsyncChan(foRunner_inChan)
		:: else -> 
			run sync_monitor(foRunner_inChan)
		fi
	:: true -> 
		run sync_monitor(foRunner_stopChan)
	:: true -> 
		run sync_monitor(foRunner_stopChan)
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

