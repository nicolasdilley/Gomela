
// /tmp/clone-example241355449/cmd/siad/daemon.go
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
	Chandef sigChan;
	Chandef mmapChan;
	bool state = false;
	Chandef errChan;
	int i;
	
	if
	:: true -> 
		
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
			fi
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
			fi
		fi
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		mmapChan.size = 1;
		run AsyncChan(mmapChan)
	:: else -> 
		run sync_monitor(mmapChan)
	fi;
	do
	:: mmapChan!0 -> 
		break
	:: true -> 
		break
	od;
	run Anonymous0(mmapChan,errChan,sigChan);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(errChan);
	run Anonymous1(mmapChan,errChan,sigChan);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		sigChan.size = 1;
		run AsyncChan(sigChan)
	:: else -> 
		run sync_monitor(sigChan)
	fi;
	do
	:: sigChan!0 -> 
		break
	:: true -> 
		break
	od;
	do
	:: sigChan.async_rcv?0 -> 
		goto stop_process
	:: sigChan.sync?0 -> 
		goto stop_process
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef mmapChan;Chandef errChan;Chandef sigChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: mmapChan.async_rcv?0;
	:: mmapChan.sync?0;
	fi;
stop_process:
}
proctype Anonymous1(Chandef mmapChan;Chandef errChan;Chandef sigChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: errChan.async_send!0;
	:: errChan.sync!0 -> 
		errChan.sending?0
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
