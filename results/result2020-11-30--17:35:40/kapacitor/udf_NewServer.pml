
// /tmp/clone-example660668482/udf/server.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef s_inMsg;
	Wgdef s_requestsGroup;
	Chandef s_snapshotResponse;
	Chandef s_requests;
	Chandef s_infoResponse;
	int i;
	Wgdef s_ioGroup;
	Chandef s_keepalive;
	Chandef s_outMsg;
	Chandef s_initResponse;
	Chandef s_restoreResponse;
	bool state = false;
	run wgMonitor(s_requestsGroup);
	run wgMonitor(s_ioGroup);
	run sync_monitor(s_requests);
	
	if
	:: 1 > 0 -> 
		s_keepalive.size = 1;
		run AsyncChan(s_keepalive)
	:: else -> 
		run sync_monitor(s_keepalive)
	fi;
	run sync_monitor(s_inMsg);
	run sync_monitor(s_outMsg);
	
	if
	:: 1 > 0 -> 
		s_infoResponse.size = 1;
		run AsyncChan(s_infoResponse)
	:: else -> 
		run sync_monitor(s_infoResponse)
	fi;
	
	if
	:: 1 > 0 -> 
		s_initResponse.size = 1;
		run AsyncChan(s_initResponse)
	:: else -> 
		run sync_monitor(s_initResponse)
	fi;
	
	if
	:: 1 > 0 -> 
		s_snapshotResponse.size = 1;
		run AsyncChan(s_snapshotResponse)
	:: else -> 
		run sync_monitor(s_snapshotResponse)
	fi;
	
	if
	:: 1 > 0 -> 
		s_restoreResponse.size = 1;
		run AsyncChan(s_restoreResponse)
	:: else -> 
		run sync_monitor(s_restoreResponse)
	fi;
	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
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

