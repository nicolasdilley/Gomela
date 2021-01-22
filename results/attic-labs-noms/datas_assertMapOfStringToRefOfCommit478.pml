
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example006988768/go/datas/remote_database_handlers.go
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
	Chandef changes;
	Chandef stopChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	run sync_monitor(stopChan);
	run sync_monitor(changes);
	run go_Anonymous0(stopChan,changes);
	do
	:: true -> 
		

		if
		:: changes.async_rcv?state,num_msgs;
		:: changes.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	stopChan.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef stopChan;Chandef changes) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Diff0 = [0] of {int};
	run Diff(changes,stopChan,child_Diff0);
	child_Diff0?0;
	stop_process: skip;
	changes.closing!true
}
proctype Diff(Chandef changes;Chandef closeChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DiffWithLimit0 = [0] of {int};
	run DiffWithLimit(changes,closeChan,child_DiffWithLimit0);
	child_DiffWithLimit0?0;
	stop_process: skip;
	child!0
}
proctype DiffWithLimit(Chandef changes;Chandef closeChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_typesindexedSequenceDiff0 = [0] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: changes.async_send!0;
		:: changes.sync!false,0 -> 
			changes.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: changes.async_send!0;
		:: changes.sync!false,0 -> 
			changes.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	run typesindexedSequenceDiff(changes,closeChan,child_typesindexedSequenceDiff0);
	child_typesindexedSequenceDiff0?0;
	stop_process: skip;
	child!0
}
proctype typesindexedSequenceDiff(Chandef changes;Chandef closeChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_typesindexedSequenceDiff4 = [0] of {int};
	chan child_typessendSpliceChange3 = [0] of {int};
	chan child_typessendSpliceChange2 = [0] of {int};
	chan child_typesindexedSequenceDiff4 = [0] of {int};
	chan child_typessendSpliceChange3 = [0] of {int};
	chan child_typessendSpliceChange2 = [0] of {int};
	chan child_typesindexedSequenceDiff1 = [0] of {int};
	chan child_typesindexedSequenceDiff0 = [0] of {int};
	int initialSplices = -2;
	

	if
	:: true -> 
		run typesindexedSequenceDiff(changes,closeChan,child_typesindexedSequenceDiff0);
		child_typesindexedSequenceDiff0?0;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run typesindexedSequenceDiff(changes,closeChan,child_typesindexedSequenceDiff1);
		child_typesindexedSequenceDiff1?0;
		goto stop_process
	:: true;
	fi;
	

	if
	:: initialSplices-1 != -3 -> 
				for(i : 0.. initialSplices-1) {
			for10: skip;
			

			if
			:: true -> 
				run typessendSpliceChange(changes,closeChan,child_typessendSpliceChange2);
				child_typessendSpliceChange2?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto for10_end
			:: true;
			fi;
			

			if
			:: true -> 
				run typessendSpliceChange(changes,closeChan,child_typessendSpliceChange3);
				child_typessendSpliceChange3?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto for10_end
			:: true;
			fi;
			run typesindexedSequenceDiff(changes,closeChan,child_typesindexedSequenceDiff4);
			child_typesindexedSequenceDiff4?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10420: skip;
			

			if
			:: true -> 
				run typessendSpliceChange(changes,closeChan,child_typessendSpliceChange2);
				child_typessendSpliceChange2?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto for10_end420
			:: true;
			fi;
			

			if
			:: true -> 
				run typessendSpliceChange(changes,closeChan,child_typessendSpliceChange3);
				child_typessendSpliceChange3?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto for10_end420
			:: true;
			fi;
			run typesindexedSequenceDiff(changes,closeChan,child_typesindexedSequenceDiff4);
			child_typesindexedSequenceDiff4?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end420: skip
		:: true -> 
			break
		od;
		for10_exit420: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype typessendSpliceChange(Chandef changes;Chandef closeChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: changes.async_send!0 -> 
		break
	:: changes.sync!0 -> 
		changes.sending?state;
		break
	:: closeChan.async_rcv?state,num_msgs -> 
		goto stop_process
	:: closeChan.sync?state,num_msgs -> 
		goto stop_process
	od;
	goto stop_process;
	stop_process: skip;
	child!0
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

