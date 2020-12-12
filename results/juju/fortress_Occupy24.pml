#define lb_for56_0  -1
#define ub_for56_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example787825356/worker/fortress/occupy.go
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
	Chandef failed;
	Chandef started;
	Chandef finished;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		started.size = 1;
		run AsyncChan(started)
	:: else -> 
		run sync_monitor(started)
	fi;
	
	if
	:: 1 > 0 -> 
		failed.size = 1;
		run AsyncChan(failed)
	:: else -> 
		run sync_monitor(failed)
	fi;
	
	if
	:: 1 > 0 -> 
		finished.size = 1;
		run AsyncChan(finished)
	:: else -> 
		run sync_monitor(finished)
	fi;
	run Anonymous0(started,failed,finished);
	do
	:: true -> 
for10:		do
		:: finished.async_rcv?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: finished.sync?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: failed.async_rcv?0 -> 
			goto stop_process
		:: failed.sync?0 -> 
			goto stop_process
		:: started.async_rcv?0 -> 
			goto stop_process
		:: started.sync?0 -> 
			goto stop_process
		od
	od;
for10_exit:
stop_process:}

proctype Anonymous0(Chandef started;Chandef failed;Chandef finished) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: finished.async_send!0;
	:: finished.sync!0 -> 
		finished.sending?0
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

