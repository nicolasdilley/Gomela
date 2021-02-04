#define IndexDiff_IndexOperationConcurrency  0

// https://github.com/convox/rack/blob/ee5e31801fa5f2e69aa3bd41339db0b4f64c82fe/provider/aws/index.go#L18
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
	Chandef errch;
	Chandef outch;
	Chandef inch;
	int num_msgs = 0;
	bool state = false;
	int i;
	int index=3;
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
			:: outch.async_rcv?state,num_msgs -> 
				break
			:: outch.sync?state,num_msgs -> 
				break
			:: errch.async_rcv?state,num_msgs -> 
				goto stop_process
			:: errch.sync?state,num_msgs -> 
				goto stop_process
			od;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for30666: skip;
			do
			:: outch.async_rcv?state,num_msgs -> 
				break
			:: outch.sync?state,num_msgs -> 
				break
			:: errch.async_rcv?state,num_msgs -> 
				goto stop_process
			:: errch.sync?state,num_msgs -> 
				goto stop_process
			od;
			for30_end666: skip
		:: true -> 
			break
		od;
		for30_exit666: skip
	fi;
	inch.closing!true;
	goto stop_process
stop_process:skip
}

proctype go_missingHashes(Chandef inch;Chandef outch;Chandef errch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: inch.async_rcv?state,num_msgs;
		:: inch.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: errch.async_send!0;
				:: errch.sync!false,0 -> 
					errch.sending?state
				fi
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: outch.async_send!0;
					:: outch.sync!false,0 -> 
						outch.sending?state
					fi
				:: true -> 
					

					if
					:: outch.async_send!0;
					:: outch.sync!false,0 -> 
						outch.sending?state
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
	int num_msgs;
	

	if
	:: index-1 != -3 -> 
				for(i : 0.. index-1) {
			for20: skip;
			

			if
			:: inch.async_send!0;
			:: inch.sync!false,0 -> 
				inch.sending?state
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20663: skip;
			

			if
			:: inch.async_send!0;
			:: inch.sync!false,0 -> 
				inch.sending?state
			fi;
			for20_end663: skip
		:: true -> 
			break
		od;
		for20_exit663: skip
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


