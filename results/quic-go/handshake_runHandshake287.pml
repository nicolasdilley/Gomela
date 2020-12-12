#define lb_for434_0  -1
#define ub_for434_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example758766998/fuzzing/handshake/fuzz.go
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
	Chandef done;
	Chandef serverHandshakeCompleted;
	bool state = false;
	Chandef clientHandshakeCompleted;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(serverHandshakeCompleted);
	run Anonymous0(serverHandshakeCompleted,clientHandshakeCompleted,done);
	run sync_monitor(clientHandshakeCompleted);
	run Anonymous1(serverHandshakeCompleted,clientHandshakeCompleted,done);
	run sync_monitor(done);
	run Anonymous2(serverHandshakeCompleted,clientHandshakeCompleted,done);
messageLoop:		do
	:: true -> 
for10:		do
		:: done.async_rcv?0 -> 
			goto messageLoop;
			break
		:: done.sync?0 -> 
			goto messageLoop;
			break
		od;
		
		if
		:: true -> 
			goto messageLoop
		:: true;
		fi
	od;
for10_exit:;
	
	if
	:: done.async_rcv?0;
	:: done.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef serverHandshakeCompleted;Chandef clientHandshakeCompleted;Chandef done) {
	bool closed; 
	int i;
	bool state;
stop_process:	serverHandshakeCompleted.closing!true
}
proctype Anonymous1(Chandef serverHandshakeCompleted;Chandef clientHandshakeCompleted;Chandef done) {
	bool closed; 
	int i;
	bool state;
stop_process:	clientHandshakeCompleted.closing!true
}
proctype Anonymous2(Chandef serverHandshakeCompleted;Chandef clientHandshakeCompleted;Chandef done) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: serverHandshakeCompleted.async_rcv?0;
	:: serverHandshakeCompleted.sync?0;
	fi;
	
	if
	:: clientHandshakeCompleted.async_rcv?0;
	:: clientHandshakeCompleted.sync?0;
	fi;
	done.closing!true;
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

