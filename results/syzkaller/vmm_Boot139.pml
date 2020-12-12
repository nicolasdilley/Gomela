
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example504704722/vm/vmm/vmm.go
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
	bool state = false;
	Chandef ipch;
	Chandef bootOutputStop;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(bootOutputStop);
	
	if
	:: 1 > 0 -> 
		ipch.size = 1;
		run AsyncChan(ipch)
	:: else -> 
		run sync_monitor(ipch)
	fi;
	run Anonymous0(bootOutputStop,ipch);
	do
	:: ipch.async_rcv?0 -> 
		break
	:: ipch.sync?0 -> 
		break
	:: true -> 
		
		if
		:: bootOutputStop.async_send!0;
		:: bootOutputStop.sync!0 -> 
			bootOutputStop.sending?0
		fi;
		
		if
		:: bootOutputStop.async_rcv?0;
		:: bootOutputStop.sync?0;
		fi;
		goto stop_process
	od;
	
	if
	:: true -> 
		
		if
		:: bootOutputStop.async_send!0;
		:: bootOutputStop.sync!0 -> 
			bootOutputStop.sending?0
		fi;
		
		if
		:: bootOutputStop.async_rcv?0;
		:: bootOutputStop.sync?0;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: bootOutputStop.async_send!0;
	:: bootOutputStop.sync!0 -> 
		bootOutputStop.sending?0
	fi;
	
	if
	:: bootOutputStop.async_rcv?0;
	:: bootOutputStop.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef bootOutputStop;Chandef ipch) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: bootOutputStop.async_rcv?0 -> 
			
			if
			:: bootOutputStop.async_send!0;
			:: bootOutputStop.sync!0 -> 
				bootOutputStop.sending?0
			fi;
			goto stop_process
		:: bootOutputStop.sync?0 -> 
			
			if
			:: bootOutputStop.async_send!0;
			:: bootOutputStop.sync!0 -> 
				bootOutputStop.sending?0
			fi;
			goto stop_process
		od;
		
		if
		:: true -> 
			
			if
			:: ipch.async_send!0;
			:: ipch.sync!0 -> 
				ipch.sending?0
			fi
		:: true;
		fi
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

