
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example639229064/pipeline/plugin_runners.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef foRunner_inChan;
	Chandef foRunner_stopChan;
	Chandef bufErrChan;
	Chandef pluginErrChan;
	int num_msgs = 0;
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
	run go_Anonymous0(pluginErrChan,bufErrChan);
	run go_Anonymous1(pluginErrChan,bufErrChan);
	do
	:: pluginErrChan.async_rcv?state,num_msgs -> 
		break
	:: pluginErrChan.sync?state,num_msgs -> 
		break
	:: bufErrChan.async_rcv?state,num_msgs -> 
		break
	:: bufErrChan.sync?state,num_msgs -> 
		break
	od;
	

	if
	:: true -> 
		

		if
		:: pluginErrChan.async_rcv?state,num_msgs;
		:: pluginErrChan.sync?state,num_msgs;
		fi;
		

		if
		:: 2 > 0 -> 
			foRunner_inChan.size = 2;
			run AsyncChan(foRunner_inChan)
		:: else -> 
			run sync_monitor(foRunner_inChan)
		fi
	:: true -> 
		

		if
		:: bufErrChan.async_rcv?state,num_msgs;
		:: bufErrChan.sync?state,num_msgs;
		fi;
		run sync_monitor(foRunner_stopChan)
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef pluginErrChan;Chandef bufErrChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: pluginErrChan.async_send!0;
	:: pluginErrChan.sync!false,0 -> 
		pluginErrChan.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef pluginErrChan;Chandef bufErrChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: bufErrChan.async_send!0;
	:: bufErrChan.sync!false,0 -> 
		bufErrChan.sending?state
	fi;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

