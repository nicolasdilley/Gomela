#define NewReporterKBPKI_bufSize  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example587037361/go/kbfs/libkbfs/reporter_kbpki.go
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
	Chandef r_shutdownCh;
	Chandef r_notifyFavsBuffer;
	Chandef r_notifyOverallSyncBuffer;
	Chandef r_notifySyncBuffer;
	Chandef r_notifyPathBuffer;
	Chandef r_onlineStatusBuffer;
	Chandef r_notifyBuffer;
	int num_msgs = 0;
	bool state = false;
	int i;
	int bufSize = NewReporterKBPKI_bufSize;
	

	if
	:: bufSize > 0 -> 
		r_notifyBuffer.size = bufSize;
		run AsyncChan(r_notifyBuffer)
	:: else -> 
		run sync_monitor(r_notifyBuffer)
	fi;
	

	if
	:: bufSize > 0 -> 
		r_onlineStatusBuffer.size = bufSize;
		run AsyncChan(r_onlineStatusBuffer)
	:: else -> 
		run sync_monitor(r_onlineStatusBuffer)
	fi;
	

	if
	:: 1 > 0 -> 
		r_notifyPathBuffer.size = 1;
		run AsyncChan(r_notifyPathBuffer)
	:: else -> 
		run sync_monitor(r_notifyPathBuffer)
	fi;
	

	if
	:: 1 > 0 -> 
		r_notifySyncBuffer.size = 1;
		run AsyncChan(r_notifySyncBuffer)
	:: else -> 
		run sync_monitor(r_notifySyncBuffer)
	fi;
	

	if
	:: 1 > 0 -> 
		r_notifyOverallSyncBuffer.size = 1;
		run AsyncChan(r_notifyOverallSyncBuffer)
	:: else -> 
		run sync_monitor(r_notifyOverallSyncBuffer)
	fi;
	

	if
	:: 1 > 0 -> 
		r_notifyFavsBuffer.size = 1;
		run AsyncChan(r_notifyFavsBuffer)
	:: else -> 
		run sync_monitor(r_notifyFavsBuffer)
	fi;
	run sync_monitor(r_shutdownCh);
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

