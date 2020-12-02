#define IndexDownload_IndexOperationConcurrency  3

// /tmp/clone-example952655720/provider/aws/index.go
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
	Chandef errch;
	Chandef inch;
	int IndexOperationConcurrency = IndexDownload_IndexOperationConcurrency;
	bool state = false;
	run sync_monitor(inch);
	run sync_monitor(errch);
for10_exit:	run Anonymous1(inch,errch);
	goto stop_process
stop_process:}

proctype go_pdownloadItems(Chandef inch;Chandef errch) {
	bool closed; 
	int i;
	bool state;
	do
	:: inch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: inch.async_rcv?0;
			:: inch.sync?0;
			fi;
			
			if
			:: errch.async_send!0;
			:: errch.sync!0 -> 
				errch.sending?0
			fi
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef inch;Chandef errch) {
	bool closed; 
	int i;
	bool state;
		for(i : 0.. index-1) {
for20:		
		if
		:: inch.async_send!0;
		:: inch.sync!0 -> 
			inch.sending?0
		fi
	};
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
