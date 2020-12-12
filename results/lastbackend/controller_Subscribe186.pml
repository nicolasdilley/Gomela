
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example208501440/pkg/node/controller/controller.go
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
	Chandef volumes;
	Chandef pods;
	Chandef done;
	bool state = false;
	run sync_monitor(pods);
	run sync_monitor(volumes);
	run sync_monitor(done);
	run Anonymous0(pods,volumes,done);
	run go_Watch(pods,done);
	run go_Watch(volumes,done);
	
	if
	:: done.async_rcv?0;
	:: done.sync?0;
	fi
stop_process:}

proctype Anonymous0(Chandef pods;Chandef volumes;Chandef done) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: pods.async_rcv?0 -> 
			goto for10_exit
		:: pods.sync?0 -> 
			goto for10_exit;
			break
		:: volumes.async_rcv?0 -> 
			goto for10_exit
		:: volumes.sync?0 -> 
			goto for10_exit;
			break
		od
	od;
for10_exit:stop_process:
}
proctype go_Watch(Chandef watcher;Chandef done) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: done.async_rcv?0;
	:: done.sync?0;
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

