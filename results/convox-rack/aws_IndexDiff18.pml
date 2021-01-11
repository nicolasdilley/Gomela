#define IndexDiff_IndexOperationConcurrency  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example287807526/provider/aws/index.go
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
	Chandef errch;
	Chandef outch;
	Chandef inch;
	bool state = false;
	int i;
	int index=0;
	int IndexOperationConcurrency = IndexDiff_IndexOperationConcurrency;
	run sync_monitor(inch);
	run sync_monitor(outch);
	run sync_monitor(errch);
		for(i : 1.. IndexOperationConcurrency-1) {
		for10: skip;
		run go_missingHashes(inch,outch,errch);
		for10_end: skip
	};
	for10_exit: skip;
	run go_Anonymous1(inch,outch,errch,index);
	

	if
	:: index-1 != -3 -> 
				for(i : 0.. index-1) {
			for30: skip;
			do
			:: outch.async_rcv?0 -> 
				break
			:: outch.sync?0 -> 
				break
			:: errch.async_rcv?0 -> 
				goto stop_process
			:: errch.sync?0 -> 
				goto stop_process
			od;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for301563: skip;
			do
			:: outch.async_rcv?0 -> 
				break
			:: outch.sync?0 -> 
				break
			:: errch.async_rcv?0 -> 
				goto stop_process
			:: errch.sync?0 -> 
				goto stop_process
			od;
			for30_end1563: skip
		:: true -> 
			break
		od;
		for30_exit1563: skip
	fi;
	inch.closing!true;
	goto stop_process
stop_process:skip
}

proctype go_missingHashes(Chandef inch;Chandef outch;Chandef errch) {
	bool closed; 
	int i;
	bool state;
	do
	:: inch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: inch.async_rcv?0;
			:: inch.sync?0;
			fi;
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: errch.async_send!0;
				:: errch.sync!0 -> 
					errch.sending?0
				fi
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: outch.async_send!0;
					:: outch.sync!0 -> 
						outch.sending?0
					fi
				:: true -> 
					

					if
					:: outch.async_send!0;
					:: outch.sync!0 -> 
						outch.sending?0
					fi
				:: true -> 
					

					if
					:: outch.async_send!0;
					:: outch.sync!0 -> 
						outch.sending?0
					fi
				fi
			fi;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	stop_process: skip
}
proctype go_Anonymous1(Chandef inch;Chandef outch;Chandef errch;int index) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: index-1 != -3 -> 
				for(i : 0.. index-1) {
			for20: skip;
			

			if
			:: inch.async_send!0;
			:: inch.sync!0 -> 
				inch.sending?0
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for201560: skip;
			

			if
			:: inch.async_send!0;
			:: inch.sync!0 -> 
				inch.sending?0
			fi;
			for20_end1560: skip
		:: true -> 
			break
		od;
		for20_exit1560: skip
	fi;
	stop_process: skip
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


