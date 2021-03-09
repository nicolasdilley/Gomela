#define collectDataOnce_batchCnt  1
#define ub_for82_1  0

// https://github.com/open-falcon/falcon-plus/blob/0c37ac5b9412e90c560571563e9a6824eea2e03f/modules/nodata/collector/collector_cron.go#L61
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
	Chandef rch;
	int num_msgs = 0;
	bool state = false;
	int i;
	int batchCnt = collectDataOnce_batchCnt;
	

	if
	:: batchCnt + 1 > 0 -> 
		rch.size = batchCnt + 1;
		run AsyncChan(rch)
	:: else -> 
		run sync_monitor(rch)
	fi;
		for(i : 0.. ub_for82_1) {
		for10: skip;
		run go_Anonymous0(rch);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && batchCnt-1 != -3 -> 
				for(i : 0.. batchCnt-1) {
			for2044: skip;
			do
			:: rch.async_rcv?state,num_msgs -> 
				break
			:: rch.sync?state,num_msgs -> 
				break
			od;
			for20_end44: skip
		};
		for20_exit44: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: rch.async_rcv?state,num_msgs -> 
				break
			:: rch.sync?state,num_msgs -> 
				break
			od;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef rch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: rch.async_send!0;
	:: rch.sync!false,0 -> 
		rch.sending?state
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

