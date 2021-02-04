#define newTCertPoolEntry_client_conf_getTCertBatchSize3841  3
#define newTCertPoolEntry_client_conf_getTCertBatchSize3946  1

// https://github.com/hyperledger-archives/fabric/blob/fd7d34e07fdef96cbc11216337a6aca530dce846/core/crypto/client_tcert_pool_mt.go#L37
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
	Chandef done;
	Chandef tCertChannelFeedback;
	Chandef tCertChannel;
	int num_msgs = 0;
	bool state = false;
	int i;
	int client_conf_getTCertBatchSize3946 = newTCertPoolEntry_client_conf_getTCertBatchSize3946;
	int client_conf_getTCertBatchSize3841 = newTCertPoolEntry_client_conf_getTCertBatchSize3841;
	

	if
	:: client_conf_getTCertBatchSize3841 * 2 > 0 -> 
		tCertChannel.size = client_conf_getTCertBatchSize3841 * 2;
		run AsyncChan(tCertChannel)
	:: else -> 
		run sync_monitor(tCertChannel)
	fi;
	

	if
	:: client_conf_getTCertBatchSize3946 * 2 > 0 -> 
		tCertChannelFeedback.size = client_conf_getTCertBatchSize3946 * 2;
		run AsyncChan(tCertChannelFeedback)
	:: else -> 
		run sync_monitor(tCertChannelFeedback)
	fi;
	

	if
	:: 1 > 0 -> 
		done.size = 1;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
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

