#define init_hostCount  1
#define init_c_Options_HostBufferFactor  1
#define init_c_Options_EnqueueChanBuffer  1

// /tmp/clone-example734681608/crawler.go
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
	Chandef c_enqueue;
	int i;
	int c_Options_HostBufferFactor = init_c_Options_HostBufferFactor;
	Chandef c_stop;
	int hostCount = init_hostCount;
	int c_Options_EnqueueChanBuffer = init_c_Options_EnqueueChanBuffer;
	bool state = false;
	run sync_monitor(c_stop);
	
	if
	:: true -> 
		Chandef c_push;
		
		if
		:: hostCount > 0 -> 
			c_push.size = hostCount;
			run AsyncChan(c_push)
		:: else -> 
			run sync_monitor(c_push)
		fi
	:: true -> 
		Chandef c_push;
		
		if
		:: c_Options_HostBufferFactor * hostCount > 0 -> 
			c_push.size = c_Options_HostBufferFactor * hostCount;
			run AsyncChan(c_push)
		:: else -> 
			run sync_monitor(c_push)
		fi
	:: true -> 
		Chandef c_push;
		
		if
		:: c_Options_HostBufferFactor * hostCount > 0 -> 
			c_push.size = c_Options_HostBufferFactor * hostCount;
			run AsyncChan(c_push)
		:: else -> 
			run sync_monitor(c_push)
		fi
	fi;
	
	if
	:: c_Options_EnqueueChanBuffer > 0 -> 
		c_enqueue.size = c_Options_EnqueueChanBuffer;
		run AsyncChan(c_enqueue)
	:: else -> 
		run sync_monitor(c_enqueue)
	fi
stop_process:}

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

