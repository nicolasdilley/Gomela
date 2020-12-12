#define Run_q_Threads  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example287172560/queue/queue.go
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
	Chandef requestc;
	int i;
	Chandef complete;
	Chandef q_wake;
	Chandef errc;
	int q_Threads = Run_q_Threads;
	bool state = false;
	run sync_monitor(q_wake);
	run sync_monitor(requestc);
	
	if
	:: 1 > 0 -> 
		errc.size = 1;
		run AsyncChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	run sync_monitor(complete);
for10_exit:	run go_loop(requestc,complete,errc);
	
	if
	:: errc.async_rcv?0;
	:: errc.sync?0;
	fi;
	goto stop_process;
	requestc.closing!true
stop_process:}

proctype go_queueindependentRunner(Chandef requestc;Chandef complete) {
	bool closed; 
	int i;
	bool state;
	do
	:: requestc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: requestc.async_rcv?0;
			:: requestc.sync?0;
			fi;
			
			if
			:: complete.async_send!0;
			:: complete.sync!0 -> 
				complete.sending?0
			fi
		fi
	od;
stop_process:
}
proctype go_loop(Chandef requestc;Chandef complete;Chandef errc) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: errc.async_send!0;
			:: errc.sync!0 -> 
				errc.sending?0
			fi;
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: errc.async_send!0;
			:: errc.sync!0 -> 
				errc.sending?0
			fi;
			break
		:: true;
		fi;
Sent:				do
		:: true -> 
for21:			do
			:: complete.async_rcv?0 -> 
				
				if
				:: true -> 
					goto Sent
				:: true;
				fi;
				break
			:: complete.sync?0 -> 
				
				if
				:: true -> 
					goto Sent
				:: true;
				fi;
				break
			od
		od;
for21_exit:
	od;
for20_exit:stop_process:
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

