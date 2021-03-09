#define executeBatches_numBatches  0
#define executeBatches_batches  1

// https://github.com/hyperledger/fabric/blob/8555262cca0e3b0c89e077a71c9c5312920b87b0/core/ledger/kvledger/txmgmt/statedb/statecouchdb/batch_util.go#L22
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef errsChan;
	Wgdef batchWG;
	int num_msgs = 0;
	bool state = false;
	int i;
	int batches = executeBatches_batches;
	int numBatches = executeBatches_numBatches;
	

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
	run wgMonitor(batchWG);
	batchWG.Add!numBatches;
	

	if
	:: numBatches > 0 -> 
		errsChan.size = numBatches;
		run AsyncChan(errsChan)
	:: else -> 
		run sync_monitor(errsChan)
	fi;
		for(i : 0.. batches-1) {
		for10: skip;
		run go_Anonymous0(errsChan,batchWG);
		for10_end: skip
	};
	for10_exit: skip;
	batchWG.Wait?0;
	do
	:: errsChan.async_rcv?state,num_msgs -> 
		goto stop_process
	:: errsChan.sync?state,num_msgs -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	errsChan.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef errsChan;Wgdef batchWG) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errsChan.async_send!0;
		:: errsChan.sync!false,0 -> 
			errsChan.sending?state
		fi
	:: true;
	fi;
	stop_process: skip;
	batchWG.Add!-1
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

proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

