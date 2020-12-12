
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example023954484/pkg/istio-agent/xds_proxy.go
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
	Chandef con_downstreamError;
	int i;
	Chandef con_responsesChan;
	Chandef con_upstreamError;
	Chandef con_requestsChan;
	Chandef con_stopChan;
	bool state = false;
	
	if
	:: 2 > 0 -> 
		con_upstreamError.size = 2;
		run AsyncChan(con_upstreamError)
	:: else -> 
		run sync_monitor(con_upstreamError)
	fi;
	
	if
	:: 2 > 0 -> 
		con_downstreamError.size = 2;
		run AsyncChan(con_downstreamError)
	:: else -> 
		run sync_monitor(con_downstreamError)
	fi;
	
	if
	:: 10 > 0 -> 
		con_requestsChan.size = 10;
		run AsyncChan(con_requestsChan)
	:: else -> 
		run sync_monitor(con_requestsChan)
	fi;
	
	if
	:: 10 > 0 -> 
		con_responsesChan.size = 10;
		run AsyncChan(con_responsesChan)
	:: else -> 
		run sync_monitor(con_responsesChan)
	fi;
	run sync_monitor(con_stopChan);
	run Anonymous0();
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
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

