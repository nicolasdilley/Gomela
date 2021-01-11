#define Batch_batch_IndexOps  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example689835807/index/upsidedown/upsidedown.go
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
	Chandef docBackIndexRowCh;
	Chandef resultChan;
	bool state = false;
	int i;
	int batch_IndexOps = Batch_batch_IndexOps;
	

	if
	:: batch_IndexOps > 0 -> 
		resultChan.size = batch_IndexOps;
		run AsyncChan(resultChan)
	:: else -> 
		run sync_monitor(resultChan)
	fi;
	

	if
	:: batch_IndexOps > 0 -> 
		docBackIndexRowCh.size = batch_IndexOps;
		run AsyncChan(docBackIndexRowCh)
	:: else -> 
		run sync_monitor(docBackIndexRowCh)
	fi;
	run go_Anonymous0(resultChan,docBackIndexRowCh,batch_IndexOps);
	resultChan.closing!true;
	do
	:: docBackIndexRowCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: docBackIndexRowCh.async_rcv?0;
			:: docBackIndexRowCh.sync?0;
			fi;
			for50: skip;
			for50_end: skip
		fi
	od;
	for50_exit: skip;
	

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
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef resultChan;Chandef docBackIndexRowCh;int batch_IndexOps) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: batch_IndexOps-1 != -3 -> 
				for(i : 0.. batch_IndexOps-1) {
			for20: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: docBackIndexRowCh.async_send!0;
			:: docBackIndexRowCh.sync!0 -> 
				docBackIndexRowCh.sending?0
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20679: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: docBackIndexRowCh.async_send!0;
			:: docBackIndexRowCh.sync!0 -> 
				docBackIndexRowCh.sending?0
			fi;
			for20_end679: skip
		:: true -> 
			break
		od;
		for20_exit679: skip
	fi;
	stop_process: skip;
	docBackIndexRowCh.closing!true
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

