
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example776515020/internal/video/thumbnail/service.go
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
	Chandef servErrc;
	Chandef cmdErrc;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		cmdErrc.size = 1;
		run AsyncChan(cmdErrc)
	:: else -> 
		run sync_monitor(cmdErrc)
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
	run Anonymous0(cmdErrc,servErrc);
	
	if
	:: 1 > 0 -> 
		servErrc.size = 1;
		run AsyncChan(servErrc)
	:: else -> 
		run sync_monitor(servErrc)
	fi;
	run Anonymous1(cmdErrc,servErrc);
	do
	:: cmdErrc.async_rcv?0 -> 
		goto stop_process
	:: cmdErrc.sync?0 -> 
		goto stop_process
	:: servErrc.async_rcv?0 -> 
		goto stop_process
	:: servErrc.sync?0 -> 
		goto stop_process
	od
stop_process:}

proctype Anonymous0(Chandef cmdErrc;Chandef servErrc) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: cmdErrc.async_send!0;
		:: cmdErrc.sync!0 -> 
			cmdErrc.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: cmdErrc.async_send!0;
		:: cmdErrc.sync!0 -> 
			cmdErrc.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: cmdErrc.async_send!0;
	:: cmdErrc.sync!0 -> 
		cmdErrc.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef cmdErrc;Chandef servErrc) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: servErrc.async_send!0;
	:: servErrc.sync!0 -> 
		servErrc.sending?0
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

