
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example036208822/store/sqlstore/thread_store.go
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
	Chandef threadsChan;
	Chandef totalUnreadMentionsChan;
	Chandef totalCountChan;
	Chandef totalUnreadRepliesChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	

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
	run go_Anonymous0(totalUnreadRepliesChan,totalCountChan,totalUnreadMentionsChan,threadsChan);
	run go_Anonymous1(totalUnreadRepliesChan,totalCountChan,totalUnreadMentionsChan,threadsChan);
	run go_Anonymous2(totalUnreadRepliesChan,totalCountChan,totalUnreadMentionsChan,threadsChan);
	run go_Anonymous3(totalUnreadRepliesChan,totalCountChan,totalUnreadMentionsChan,threadsChan);
	

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
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef totalUnreadRepliesChan;Chandef totalCountChan;Chandef totalUnreadMentionsChan;Chandef threadsChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: totalUnreadRepliesChan.async_send!0;
	:: totalUnreadRepliesChan.sync!false,0 -> 
		totalUnreadRepliesChan.sending?state
	fi;
	totalUnreadRepliesChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous1(Chandef totalUnreadRepliesChan;Chandef totalCountChan;Chandef totalUnreadMentionsChan;Chandef threadsChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: totalCountChan.async_send!0;
	:: totalCountChan.sync!false,0 -> 
		totalCountChan.sending?state
	fi;
	totalCountChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous2(Chandef totalUnreadRepliesChan;Chandef totalCountChan;Chandef totalUnreadMentionsChan;Chandef threadsChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: totalUnreadMentionsChan.async_send!0;
	:: totalUnreadMentionsChan.sync!false,0 -> 
		totalUnreadMentionsChan.sending?state
	fi;
	totalUnreadMentionsChan.closing!true;
	stop_process: skip
}
proctype go_Anonymous3(Chandef totalUnreadRepliesChan;Chandef totalCountChan;Chandef totalUnreadMentionsChan;Chandef threadsChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: threadsChan.async_send!0;
	:: threadsChan.sync!false,0 -> 
		threadsChan.sending?state
	fi;
	threadsChan.closing!true;
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

