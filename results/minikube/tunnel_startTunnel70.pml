
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example394682930/pkg/minikube/tunnel/tunnel_manager.go
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
	Chandef check;
	Chandef ready;
	Chandef done;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		ready.size = 1;
		run AsyncChan(ready)
	:: else -> 
		run sync_monitor(ready)
	fi;
	
	if
	:: 1 > 0 -> 
		check.size = 1;
		run AsyncChan(check)
	:: else -> 
		run sync_monitor(check)
	fi;
	
	if
	:: 1 > 0 -> 
		done.size = 1;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run go_timerLoop(ready,check);
	run go_run(ready,check,done);
	goto stop_process
stop_process:}

proctype go_timerLoop(Chandef ready;Chandef check) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: ready.async_rcv?0;
		:: ready.sync?0;
		fi;
		
		if
		:: check.async_send!0;
		:: check.sync!0 -> 
			check.sending?0
		fi
	od;
for10_exit:stop_process:
}
proctype go_run(Chandef ready;Chandef check;Chandef done) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: ready.async_send!0;
	:: ready.sync!0 -> 
		ready.sending?0
	fi;
	do
	:: true -> 
for20:		do
		:: check.async_rcv?0 -> 
			do
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: ready.async_send!0;
			:: ready.sync!0 -> 
				ready.sending?0
			fi;
			break
		:: check.sync?0 -> 
			do
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: ready.async_send!0;
			:: ready.sync!0 -> 
				ready.sending?0
			fi;
			break
		od
	od;
for20_exit:stop_process:	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
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

