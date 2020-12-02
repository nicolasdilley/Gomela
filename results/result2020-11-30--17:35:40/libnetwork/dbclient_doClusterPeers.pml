#define doClusterPeers_ips  3
#define doClusterPeers_maxRetry  1

// /tmp/clone-example637104916/cmd/networkdb-test/dbclient/ndbClient.go
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
	int ips = doClusterPeers_ips;
	Chandef doneCh;
	int maxRetry = doClusterPeers_maxRetry;
	bool state = false;
	
	if
	:: ips > 0 -> 
		doneCh.size = ips;
		run AsyncChan(doneCh)
	:: else -> 
		run sync_monitor(doneCh)
	fi;
	
	if
	:: 0 != -2 && maxRetry-1 != -3 -> 
				for(i : 0.. maxRetry-1) {
for10:						for(i : 0.. ips-1) {
for11:				run go_dbclientclusterPeersNumber(doneCh)
			};
			
			if
			:: 0 != -2 && ips-1 != -3 -> 
								for(i : 0.. ips-1) {
for12:					
					if
					:: doneCh.async_rcv?0;
					:: doneCh.sync?0;
					fi
				}
			:: else -> 
				do
				:: true -> 
for12:					
					if
					:: doneCh.async_rcv?0;
					:: doneCh.sync?0;
					fi
				:: true -> 
					break
				od
			fi;
for12_exit:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:						for(i : 0.. ips-1) {
for11:				run go_dbclientclusterPeersNumber(doneCh)
			};
			
			if
			:: 0 != -2 && ips-1 != -3 -> 
								for(i : 0.. ips-1) {
for12:					
					if
					:: doneCh.async_rcv?0;
					:: doneCh.sync?0;
					fi
				}
			:: else -> 
				do
				:: true -> 
for12:					
					if
					:: doneCh.async_rcv?0;
					:: doneCh.sync?0;
					fi
				:: true -> 
					break
				od
			fi;
for12_exit:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	doneCh.closing!true
stop_process:}

proctype go_dbclientclusterPeersNumber(Chandef doneCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: doneCh.async_send!0;
		:: doneCh.sync!0 -> 
			doneCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: doneCh.async_send!0;
	:: doneCh.sync!0 -> 
		doneCh.sending?0
	fi;
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

