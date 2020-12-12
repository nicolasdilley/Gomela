
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example147175247/notify.go
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
	chan child_pqnewDialListenerConn0 = [0] of {int};
	Chandef notificationChan;
	chan child_resync1 = [0] of {int};
	bool state = false;
	
	if
	:: 32 > 0 -> 
		notificationChan.size = 32;
		run AsyncChan(notificationChan)
	:: else -> 
		run sync_monitor(notificationChan)
	fi;
	run pqnewDialListenerConn(notificationChan,child_pqnewDialListenerConn0);
	child_pqnewDialListenerConn0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run resync(notificationChan,child_resync1);
	child_resync1?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype pqnewDialListenerConn(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef l_replyChan;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 2 > 0 -> 
		l_replyChan.size = 2;
		run AsyncChan(l_replyChan)
	:: else -> 
		run sync_monitor(l_replyChan)
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype resync(Chandef notificationChan;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef doneChan;
	run sync_monitor(doneChan);
	run Anonymous1(notificationChan,doneChan);
	do
	:: true -> 
for20:		do
		:: doneChan.async_rcv?0 -> 
			goto stop_process
		:: doneChan.sync?0 -> 
			goto stop_process
		od
	od;
for20_exit:stop_process:	child!0
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

