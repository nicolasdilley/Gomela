
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example345100317/Godeps/_workspace/src/github.com/lib/pq/notify.go
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
	chan child_resync1 = [0] of {int};
	chan child_pqNewListenerConn0 = [0] of {int};
	Chandef notificationChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 32 > 0 -> 
		notificationChan.size = 32;
		run AsyncChan(notificationChan)
	:: else -> 
		run sync_monitor(notificationChan)
	fi;
	run pqNewListenerConn(notificationChan,child_pqNewListenerConn0);
	child_pqNewListenerConn0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run resync(notificationChan,child_resync1);
	child_resync1?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype pqNewListenerConn(Chandef notificationChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef l_replyChan;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 2 > 0 -> 
		l_replyChan.size = 2;
		run AsyncChan(l_replyChan)
	:: else -> 
		run sync_monitor(l_replyChan)
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype resync(Chandef notificationChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef doneChan;
	run sync_monitor(doneChan);
	run go_Anonymous2(doneChan,notificationChan);
	do
	:: true -> 
		for20: skip;
		do
		:: notificationChan.async_rcv?state,num_msgs -> 
			break
		:: notificationChan.sync?state,num_msgs -> 
			break
		:: doneChan.async_rcv?state,num_msgs -> 
			goto stop_process
		:: doneChan.sync?state,num_msgs -> 
			goto stop_process
		od;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip;
	child!0
}
proctype go_Anonymous2(Chandef doneChan;Chandef notificationChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int l_channels=0;
	

	if
	:: l_channels-1 != -3 -> 
				for(i : 0.. l_channels-1) {
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: doneChan.async_send!0;
				:: doneChan.sync!false,0 -> 
					doneChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				do
				:: true -> 
					

					if
					:: notificationChan.async_rcv?state,num_msgs;
					:: notificationChan.sync?state,num_msgs;
					fi;
					

					if
					:: state && num_msgs <= 0 -> 
						break
					:: else -> 
						for11: skip;
						for11_end: skip
					fi
				od;
				for11_exit: skip;
				

				if
				:: doneChan.async_send!0;
				:: doneChan.sync!false,0 -> 
					doneChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for102171: skip;
			

			if
			:: true -> 
				

				if
				:: doneChan.async_send!0;
				:: doneChan.sync!false,0 -> 
					doneChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				do
				:: true -> 
					

					if
					:: notificationChan.async_rcv?state,num_msgs;
					:: notificationChan.sync?state,num_msgs;
					fi;
					

					if
					:: state && num_msgs <= 0 -> 
						break
					:: else -> 
						for112171: skip;
						for11_end2171: skip
					fi
				od;
				for11_exit2171: skip;
				

				if
				:: doneChan.async_send!0;
				:: doneChan.sync!false,0 -> 
					doneChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			for10_end2171: skip
		:: true -> 
			break
		od;
		for10_exit2171: skip
	fi;
	

	if
	:: doneChan.async_send!0;
	:: doneChan.sync!false,0 -> 
		doneChan.sending?state
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


