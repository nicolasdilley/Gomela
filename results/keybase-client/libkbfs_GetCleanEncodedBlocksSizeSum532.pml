#define GetCleanEncodedBlocksSizeSum_ptrs  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example587037361/go/kbfs/libkbfs/folder_block_ops.go
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
	Chandef sumCh;
	Chandef ptrCh;
	int num_msgs = 0;
	bool state = false;
	int i;
	int ptrs = GetCleanEncodedBlocksSizeSum_ptrs;
	

	if
	:: ptrs > 0 -> 
		ptrCh.size = ptrs;
		run AsyncChan(ptrCh)
	:: else -> 
		run sync_monitor(ptrCh)
	fi;
	

	if
	:: ptrs > 0 -> 
		sumCh.size = ptrs;
		run AsyncChan(sumCh)
	:: else -> 
		run sync_monitor(sumCh)
	fi;
	

	if
	:: ptrs-1 != -3 -> 
				for(i : 0.. ptrs-1) {
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: ptrCh.async_send!0;
				:: ptrCh.sync!false,0 -> 
					ptrCh.sending?state
				fi
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10817: skip;
			

			if
			:: true -> 
				

				if
				:: ptrCh.async_send!0;
				:: ptrCh.sync!false,0 -> 
					ptrCh.sending?state
				fi
			:: true;
			fi;
			for10_end817: skip
		:: true -> 
			break
		od;
		for10_exit817: skip
	fi;
	

	if
	:: true -> 
		

		if
		:: ptrCh.async_send!0;
		:: ptrCh.sync!false,0 -> 
			ptrCh.sending?state
		fi
	:: true;
	fi;
	ptrCh.closing!true;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	sumCh.closing!true;
	do
	:: true -> 
		

		if
		:: sumCh.async_rcv?state,num_msgs;
		:: sumCh.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
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

