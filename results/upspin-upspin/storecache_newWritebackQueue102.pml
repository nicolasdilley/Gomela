
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example532188129/store/storecache/wbq.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef wbq_terminated;
	Chandef wbq_die;
	Chandef wbq_retry;
	Chandef wbq_done;
	Chandef wbq_ready;
	Chandef wbq_flushRequest;
	Chandef wbq_request;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 20 > 0 -> 
		wbq_request.size = 20;
		run AsyncChan(wbq_request)
	:: else -> 
		run sync_monitor(wbq_request)
	fi;
	

	if
	:: 20 > 0 -> 
		wbq_flushRequest.size = 20;
		run AsyncChan(wbq_flushRequest)
	:: else -> 
		run sync_monitor(wbq_flushRequest)
	fi;
	

	if
	:: 20 > 0 -> 
		wbq_ready.size = 20;
		run AsyncChan(wbq_ready)
	:: else -> 
		run sync_monitor(wbq_ready)
	fi;
	

	if
	:: 20 > 0 -> 
		wbq_done.size = 20;
		run AsyncChan(wbq_done)
	:: else -> 
		run sync_monitor(wbq_done)
	fi;
	

	if
	:: 20 > 0 -> 
		wbq_retry.size = 20;
		run AsyncChan(wbq_retry)
	:: else -> 
		run sync_monitor(wbq_retry)
	fi;
	run sync_monitor(wbq_die);
	run sync_monitor(wbq_terminated);
	goto stop_process
stop_process:skip
}


 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

