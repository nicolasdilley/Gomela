
// /tmp/clone-example569798719/pipeline/plugin_runners.go
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
	Chandef pluginErrChan;
	int i;
	Chandef bufErrChan;
	bool state = false;
	
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
	run Anonymous0(pluginErrChan,bufErrChan,foRunner_inChan,foRunner_stopChan);
	run Anonymous1(pluginErrChan,bufErrChan,foRunner_inChan,foRunner_stopChan);
	do
	od;
	
	if
	:: true -> 
		Chandef foRunner_inChan;
		
		if
		:: 2 > 0 -> 
			foRunner_inChan.size = 2;
			run AsyncChan(foRunner_inChan)
		:: else -> 
			run sync_monitor(foRunner_inChan)
		fi
	:: true -> 
		Chandef foRunner_stopChan;
		run sync_monitor(foRunner_stopChan)
	:: true -> 
		Chandef foRunner_stopChan;
		run sync_monitor(foRunner_stopChan)
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef pluginErrChan;Chandef bufErrChan;Chandef foRunner_inChan;Chandef foRunner_stopChan) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		break
	fi;
	
	if
	:: pluginErrChan.async_send!0;
	:: pluginErrChan.sync!0 -> 
		pluginErrChan.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef pluginErrChan;Chandef bufErrChan;Chandef foRunner_inChan;Chandef foRunner_stopChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: bufErrChan.async_send!0;
	:: bufErrChan.sync!0 -> 
		bufErrChan.sending?0
	fi;
stop_process:
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

