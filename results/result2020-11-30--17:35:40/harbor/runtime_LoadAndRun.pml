
// /tmp/clone-example061639583/src/jobservice/runtime/bootstrap.go
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
	Chandef rootContext_ErrorChan;
	int i;
	Chandef sig;
	bool state = false;
	
	if
	:: 5 > 0 -> 
		rootContext_ErrorChan.size = 5;
		run AsyncChan(rootContext_ErrorChan)
	:: else -> 
		run sync_monitor(rootContext_ErrorChan)
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: 1 > 0 -> 
		sig.size = 1;
		run AsyncChan(sig)
	:: else -> 
		run sync_monitor(sig)
	fi;
	do
	:: sig!0 -> 
		break
	:: true -> 
		break
	od;
	run Anonymous0(rootContext_ErrorChan,sig);
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: rootContext_ErrorChan.async_send!0;
			:: rootContext_ErrorChan.sync!0 -> 
				rootContext_ErrorChan.sending?0
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: sig.async_send!0;
		:: sig.sync!0 -> 
			sig.sending?0
		fi
	:: true -> 
		
		if
		:: sig.async_send!0;
		:: sig.sync!0 -> 
			sig.sending?0
		fi
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errChan;Chandef sig) {
	bool closed; 
	int i;
	bool state;
	do
	:: sig.async_rcv?0 -> 
		goto stop_process
	:: sig.sync?0 -> 
		goto stop_process
	:: errChan.async_rcv?0 -> 
		goto stop_process
	:: errChan.sync?0 -> 
		goto stop_process
	od;
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

