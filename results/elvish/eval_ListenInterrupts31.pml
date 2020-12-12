
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example957006753/pkg/eval/interrupts.go
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
	Chandef stop;
	Chandef sigCh;
	int i;
	Chandef intCh;
	Chandef stopped;
	bool state = false;
	run sync_monitor(sigCh);
	do
	:: sigCh!0 -> 
		break
	:: true -> 
		break
	od;
	run sync_monitor(intCh);
	run sync_monitor(stop);
	run sync_monitor(stopped);
	run Anonymous0(sigCh,intCh,stop,stopped);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef sigCh;Chandef intCh;Chandef stop;Chandef stopped) {
	bool closed; 
	int i;
	bool state;
loop:		do
	:: true -> 
for10:		do
		:: sigCh.async_rcv?0 -> 
			
			if
			:: true -> 
				intCh.closing!true
			:: true;
			fi;
			break
		:: sigCh.sync?0 -> 
			
			if
			:: true -> 
				intCh.closing!true
			:: true;
			fi;
			break
		:: stop.async_rcv?0 -> 
			goto loop;
			break
		:: stop.sync?0 -> 
			goto loop;
			break
		od
	od;
for10_exit:;
	stopped.closing!true;
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

