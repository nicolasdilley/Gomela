
// /tmp/clone-example842310962/src/build/client.go
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
	Chandef finished;
	int i;
	Chandef errch;
	Chandef success;
	Chandef sigch;
	Chandef attacherr;
	bool state = false;
	run sync_monitor(success);
	
	if
	:: 1 > 0 -> 
		finished.size = 1;
		run AsyncChan(finished)
	:: else -> 
		run sync_monitor(finished)
	fi;
	
	if
	:: 1 > 0 -> 
		sigch.size = 1;
		run AsyncChan(sigch)
	:: else -> 
		run sync_monitor(sigch)
	fi;
	
	if
	:: 1 > 0 -> 
		errch.size = 1;
		run AsyncChan(errch)
	:: else -> 
		run sync_monitor(errch)
	fi;
	
	if
	:: 1 > 0 -> 
		attacherr.size = 1;
		run AsyncChan(attacherr)
	:: else -> 
		run sync_monitor(attacherr)
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
		fi
	:: true;
	fi;
	run Anonymous0(success,finished,sigch,errch,attacherr);
	
	if
	:: success.async_rcv?0;
	:: success.sync?0;
	fi;
	
	if
	:: success.async_send!0;
	:: success.sync!0 -> 
		success.sending?0
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
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
	do
	:: sigch!0 -> 
		break
	:: true -> 
		break
	od;
	run Anonymous1(success,finished,sigch,errch,attacherr);
	do
	:: sigch.async_rcv?0 -> 
		break
	:: sigch.sync?0 -> 
		break
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef success;Chandef finished;Chandef sigch;Chandef errch;Chandef attacherr) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		do
		:: finished.async_rcv?0 -> 
			goto stop_process
		:: finished.sync?0 -> 
			goto stop_process
		:: true -> 
			
			if
			:: attacherr.async_send!0;
			:: attacherr.sync!0 -> 
				attacherr.sending?0
			fi;
			break
		od
	:: true;
	fi;
stop_process:
}
proctype Anonymous1(Chandef success;Chandef finished;Chandef sigch;Chandef errch;Chandef attacherr) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errch.async_send!0;
		:: errch.sync!0 -> 
			errch.sending?0
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: errch.async_send!0;
			:: errch.sync!0 -> 
				errch.sending?0
			fi
		:: true;
		fi
	fi;
	
	if
	:: errch.async_send!0;
	:: errch.sync!0 -> 
		errch.sending?0
	fi;
	goto stop_process;
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

