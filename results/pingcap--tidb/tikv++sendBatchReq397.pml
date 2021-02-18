#define sendBatchReq_batches  0

// https://github.com/pingcap/tidb/blob/8ddd41c960caaebbdeb28da33c781fca1464f05f/store/tikv/rawkv.go#L397
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
	Chandef ches;
	int num_msgs = 0;
	bool state = false;
	int i;
	int batches = sendBatchReq_batches;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: batches > 0 -> 
		ches.size = batches;
		run AsyncChan(ches)
	:: else -> 
		run sync_monitor(ches)
	fi;
		for(i : 0.. batches-1) {
		for20: skip;
		run go_Anonymous0(ches);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: true;
	:: true;
	fi;
	

	if
	:: 0 != -2 && batches-1 != -3 -> 
				for(i : 0.. batches-1) {
			for30910: skip;
			

			if
			:: ches.async_rcv?state,num_msgs;
			:: ches.sync?state,num_msgs;
			fi;
			for30_end910: skip
		};
		for30_exit910: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: ches.async_rcv?state,num_msgs;
			:: ches.sync?state,num_msgs;
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef ches) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: ches.async_send!0;
	:: ches.sync!false,0 -> 
		ches.sending?state
	fi;
	stop_process: skip
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

