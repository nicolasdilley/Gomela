#define DeleteChart_qSize  3
#define DeleteChart_allVersions  1

// /tmp/clone-example061639583/src/chartserver/handler_utility.go
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
	Chandef tokenQueue;
	int allVersions = DeleteChart_allVersions;
	Chandef errWrapper;
	bool state = false;
	Chandef errChan;
	int qSize = DeleteChart_qSize;
	int i;
	
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: qSize > 0 -> 
		tokenQueue.size = qSize;
		run AsyncChan(tokenQueue)
	:: else -> 
		run sync_monitor(tokenQueue)
	fi;
	
	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	
	if
	:: 0 != -2 && qSize-1 != -3 -> 
				for(i : 0.. qSize-1) {
for10:			
			if
			:: tokenQueue.async_send!0;
			:: tokenQueue.sync!0 -> 
				tokenQueue.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: tokenQueue.async_send!0;
			:: tokenQueue.sync!0 -> 
				tokenQueue.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: 1 > 0 -> 
		errWrapper.size = 1;
		run AsyncChan(errWrapper)
	:: else -> 
		run sync_monitor(errWrapper)
	fi;
	run Anonymous0(tokenQueue,errChan,errWrapper);
	errChan.closing!true;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef tokenQueue;Chandef errChan;Chandef errWrapper) {
	bool closed; 
	int i;
	bool state;
	do
	:: errChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errChan.async_rcv?0;
			:: errChan.sync?0;
			fi
		fi
	od;
stop_process:	
	if
	:: true -> 
		
		if
		:: errWrapper.async_send!0;
		:: errWrapper.sync!0 -> 
			errWrapper.sending?0
		fi
	:: true;
	fi;
	errWrapper.closing!true
}
proctype Anonymous1(Chandef tokenQueue;Chandef errChan;Chandef errWrapper) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi
	:: true;
	fi;
stop_process:	
	if
	:: tokenQueue.async_send!0;
	:: tokenQueue.sync!0 -> 
		tokenQueue.sending?0
	fi
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

