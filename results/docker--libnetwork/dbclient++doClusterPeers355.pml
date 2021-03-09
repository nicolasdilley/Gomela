#define doClusterPeers_ips  0
#define doClusterPeers_maxRetry  1

// https://github.com/docker/libnetwork/blob/954d1ddc998d8b6eb93afb628ae8ca122e53bca8/cmd/networkdb-test/dbclient/ndbClient.go#L355
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
	Chandef doneCh;
	int num_msgs = 0;
	bool state = false;
	int i;
	int maxRetry = doClusterPeers_maxRetry;
	int ips = doClusterPeers_ips;
	

	if
	:: ips > 0 -> 
		doneCh.size = ips;
		run AsyncChan(doneCh)
	:: else -> 
		run sync_monitor(doneCh)
	fi;
		for(i : 0.. maxRetry-1) {
		for10: skip;
				for(i : 0.. ips-1) {
			for11: skip;
			run go_clusterPeersNumber(doneCh);
			for11_end: skip
		};
		for11_exit: skip;
		

		if
		:: 0 != -2 && ips-1 != -3 -> 
						for(i : 0.. ips-1) {
				for11771: skip;
				

				if
				:: doneCh.async_rcv?state,num_msgs;
				:: doneCh.sync?state,num_msgs;
				fi;
				for11_end771: skip
			};
			for11_exit771: skip
		:: else -> 
			do
			:: true -> 
				for11: skip;
				

				if
				:: doneCh.async_rcv?state,num_msgs;
				:: doneCh.sync?state,num_msgs;
				fi;
				for11_end: skip
			:: true -> 
				break
			od;
			for11_exit: skip
		fi;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	doneCh.closing!true
stop_process:skip
}

proctype go_clusterPeersNumber(Chandef doneCh) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: doneCh.async_send!0;
		:: doneCh.sync!false,0 -> 
			doneCh.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: doneCh.async_send!0;
	:: doneCh.sync!false,0 -> 
		doneCh.sending?state
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

