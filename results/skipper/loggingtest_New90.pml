
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example129497272/logging/loggingtest/logger.go
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
	Chandef logc;
	Chandef mute;
	Chandef count;
	int i;
	Chandef notify;
	Chandef clear;
	Chandef quit;
	bool state = false;
	run sync_monitor(logc);
	run sync_monitor(notify);
	run sync_monitor(count);
	run sync_monitor(clear);
	run sync_monitor(mute);
	run sync_monitor(quit);
	run Anonymous0(logc,notify,count,clear,mute,quit);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef logc;Chandef notify;Chandef count;Chandef clear;Chandef mute;Chandef quit) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: logc.async_rcv?0 -> 
			break
		:: logc.sync?0 -> 
			break
		:: notify.async_rcv?0 -> 
			break
		:: notify.sync?0 -> 
			break
		:: count.async_rcv?0 -> 
			break
		:: count.sync?0 -> 
			break
		:: clear.async_rcv?0 -> 
			break
		:: clear.sync?0 -> 
			break
		:: mute.async_rcv?0 -> 
			break
		:: mute.sync?0 -> 
			break
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
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

