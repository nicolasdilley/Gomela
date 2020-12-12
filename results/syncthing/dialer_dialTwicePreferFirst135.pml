
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example666849052/lib/dialer/public.go
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
	Chandef firstDone;
	int i;
	Chandef secondDone;
	bool state = false;
	run sync_monitor(firstDone);
	run sync_monitor(secondDone);
	run Anonymous0(firstDone,secondDone);
	run Anonymous1(firstDone,secondDone);
	
	if
	:: firstDone.async_rcv?0;
	:: firstDone.sync?0;
	fi;
	
	if
	:: true -> 
		run Anonymous2(firstDone,secondDone);
		goto stop_process
	:: true;
	fi;
	
	if
	:: secondDone.async_rcv?0;
	:: secondDone.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef firstDone;Chandef secondDone) {
	bool closed; 
	int i;
	bool state;
	firstDone.closing!true;
stop_process:
}
proctype Anonymous1(Chandef firstDone;Chandef secondDone) {
	bool closed; 
	int i;
	bool state;
	do
	:: firstDone.async_rcv?0 -> 
		
		if
		:: true -> 
			secondDone.closing!true;
			goto stop_process
		:: true;
		fi;
		break
	:: firstDone.sync?0 -> 
		
		if
		:: true -> 
			secondDone.closing!true;
			goto stop_process
		:: true;
		fi;
		break
	:: true -> 
		break
	od;
	secondDone.closing!true;
stop_process:
}
proctype Anonymous2(Chandef firstDone;Chandef secondDone) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: secondDone.async_rcv?0;
	:: secondDone.sync?0;
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

