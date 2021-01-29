#define Batch_batch_IndexOps  3
#define ub_for857_1  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example334068232/index/upsidedown/upsidedown.go
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
	Chandef docBackIndexRowCh;
	Chandef resultChan;
	int num_msgs = 0;
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
	:: true -> 
		run go_Anonymous0(resultChan,batch_IndexOps)
	:: true;
	fi;
	

	if
	:: batch_IndexOps > 0 -> 
		docBackIndexRowCh.size = batch_IndexOps;
		run AsyncChan(docBackIndexRowCh)
	:: else -> 
		run sync_monitor(docBackIndexRowCh)
	fi;
	run go_Anonymous1(resultChan,docBackIndexRowCh,batch_IndexOps);
	

	if
	:: 0 != -2 && ub_for857_1 != -2 -> 
				for(i : 0.. ub_for857_1) {
			for40936: skip;
			

			if
			:: resultChan.async_rcv?state,num_msgs;
			:: resultChan.sync?state,num_msgs;
			fi;
			for40_end936: skip
		};
		for40_exit936: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: resultChan.async_rcv?state,num_msgs;
			:: resultChan.sync?state,num_msgs;
			fi;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
	resultChan.closing!true;
	do
	:: true -> 
		

		if
		:: docBackIndexRowCh.async_rcv?state,num_msgs;
		:: docBackIndexRowCh.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for60: skip;
			for60_end: skip
		fi
	od;
	for60_exit: skip;
	

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

proctype go_Anonymous0(Chandef resultChan;int batch_IndexOps) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip
}
proctype go_Anonymous1(Chandef resultChan;Chandef docBackIndexRowCh;int batch_IndexOps) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: batch_IndexOps-1 != -3 -> 
				for(i : 0.. batch_IndexOps-1) {
			for30: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: docBackIndexRowCh.async_send!0;
			:: docBackIndexRowCh.sync!false,0 -> 
				docBackIndexRowCh.sending?state
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for30935: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: docBackIndexRowCh.async_send!0;
			:: docBackIndexRowCh.sync!false,0 -> 
				docBackIndexRowCh.sending?state
			fi;
			for30_end935: skip
		:: true -> 
			break
		od;
		for30_exit935: skip
	fi;
	stop_process: skip;
	docBackIndexRowCh.closing!true
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

