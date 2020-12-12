
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example194973678/main.go
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
	int i;
	Chandef waitForFileChange;
	Chandef signalChan;
	Chandef waitForCommand;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		signalChan.size = 1;
		run AsyncChan(signalChan)
	:: else -> 
		run sync_monitor(signalChan)
	fi;
	do
	:: signalChan!0 -> 
		break
	:: true -> 
		break
	od;
	run Anonymous0(signalChan,waitForFileChange,waitForCommand);
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(waitForFileChange);
	run sync_monitor(waitForCommand);
	run Anonymous1(waitForFileChange,signalChan,waitForCommand);
	run Anonymous2(waitForCommand,signalChan,waitForFileChange);
	
	if
	:: waitForCommand.async_rcv?0;
	:: waitForCommand.sync?0;
	fi;
	
	if
	:: waitForFileChange.async_rcv?0;
	:: waitForFileChange.sync?0;
	fi
stop_process:}

proctype Anonymous0(Chandef signalChan;Chandef waitForFileChange;Chandef waitForCommand) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: signalChan.async_rcv?0;
	:: signalChan.sync?0;
	fi;
stop_process:
}
proctype Anonymous1(Chandef doneChan;Chandef signalChan;Chandef waitForCommand) {
	bool closed; 
	int i;
	bool state;
stop_process:	
	if
	:: doneChan.async_send!0;
	:: doneChan.sync!0 -> 
		doneChan.sending?0
	fi
}
proctype Anonymous2(Chandef doneChan;Chandef signalChan;Chandef waitForFileChange) {
	bool closed; 
	int i;
	bool state;
stop_process:	
	if
	:: doneChan.async_send!0;
	:: doneChan.sync!0 -> 
		doneChan.sending?0
	fi
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

