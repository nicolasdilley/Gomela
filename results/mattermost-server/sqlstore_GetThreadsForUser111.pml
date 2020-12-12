
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example135141040/store/sqlstore/thread_store.go
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
	Chandef totalCountChan;
	int i;
	Chandef threadsChan;
	Chandef totalUnreadRepliesChan;
	Chandef totalUnreadMentionsChan;
	int userIds = -2;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		totalUnreadRepliesChan.size = 1;
		run AsyncChan(totalUnreadRepliesChan)
	:: else -> 
		run sync_monitor(totalUnreadRepliesChan)
	fi;
	
	if
	:: 1 > 0 -> 
		totalCountChan.size = 1;
		run AsyncChan(totalCountChan)
	:: else -> 
		run sync_monitor(totalCountChan)
	fi;
	
	if
	:: 1 > 0 -> 
		totalUnreadMentionsChan.size = 1;
		run AsyncChan(totalUnreadMentionsChan)
	:: else -> 
		run sync_monitor(totalUnreadMentionsChan)
	fi;
	
	if
	:: 1 > 0 -> 
		threadsChan.size = 1;
		run AsyncChan(threadsChan)
	:: else -> 
		run sync_monitor(threadsChan)
	fi;
	run Anonymous0(totalUnreadRepliesChan,totalCountChan,totalUnreadMentionsChan,threadsChan);
	run Anonymous1(totalUnreadRepliesChan,totalCountChan,totalUnreadMentionsChan,threadsChan);
	run Anonymous2(totalUnreadRepliesChan,totalCountChan,totalUnreadMentionsChan,threadsChan);
	run Anonymous3(totalUnreadRepliesChan,totalCountChan,totalUnreadMentionsChan,threadsChan);
	
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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
				for(i : 0.. userIds-1) {
for20:
		}
	:: true -> 
				for(i : 0.. userIds-1) {
for20:
		}
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef totalUnreadRepliesChan;Chandef totalCountChan;Chandef totalUnreadMentionsChan;Chandef threadsChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: totalUnreadRepliesChan.async_send!0;
	:: totalUnreadRepliesChan.sync!0 -> 
		totalUnreadRepliesChan.sending?0
	fi;
	totalUnreadRepliesChan.closing!true;
stop_process:
}
proctype Anonymous1(Chandef totalUnreadRepliesChan;Chandef totalCountChan;Chandef totalUnreadMentionsChan;Chandef threadsChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: totalCountChan.async_send!0;
	:: totalCountChan.sync!0 -> 
		totalCountChan.sending?0
	fi;
	totalCountChan.closing!true;
stop_process:
}
proctype Anonymous2(Chandef totalUnreadRepliesChan;Chandef totalCountChan;Chandef totalUnreadMentionsChan;Chandef threadsChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: totalUnreadMentionsChan.async_send!0;
	:: totalUnreadMentionsChan.sync!0 -> 
		totalUnreadMentionsChan.sending?0
	fi;
	totalUnreadMentionsChan.closing!true;
stop_process:
}
proctype Anonymous3(Chandef totalUnreadRepliesChan;Chandef totalCountChan;Chandef totalUnreadMentionsChan;Chandef threadsChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: threadsChan.async_send!0;
	:: threadsChan.sync!0 -> 
		threadsChan.sending?0
	fi;
	threadsChan.closing!true;
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

