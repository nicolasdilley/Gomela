#define opts24  -2

// https://github.com/micro/micro/blob/e0a32417ab5a8e457e8257801108a124d2ca7e4f/service/build/client/client.go#L24
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
	run go_Build(opts24)
stop_process:skip
}

proctype go_Build(int opts) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef doneChan;
	Chandef errChan;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	

	if
	:: 1 > 0 -> 
		doneChan.size = 1;
		run AsyncChan(doneChan)
	:: else -> 
		run sync_monitor(doneChan)
	fi;
	run go_Anonymous1(errChan,doneChan);
	run go_Anonymous2(errChan,doneChan);
	do
	:: errChan.async_rcv?state,num_msgs -> 
		goto stop_process
	:: errChan.sync?state,num_msgs -> 
		goto stop_process
	:: doneChan.async_rcv?state,num_msgs -> 
		goto stop_process
	:: doneChan.sync?state,num_msgs -> 
		goto stop_process
	od;
	stop_process: skip
}
proctype go_Anonymous1(Chandef errChan;Chandef doneChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for20: skip;
		do
		:: true -> 
			for21: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: errChan.async_send!0;
					:: errChan.sync!false,0 -> 
						errChan.sending?state
					fi;
					goto stop_process
				:: true;
				fi
			fi;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			for21_end: skip
		od;
		for21_exit: skip;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip
}
proctype go_Anonymous2(Chandef errChan;Chandef doneChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for30: skip;
		

		if
		:: true -> 
			

			if
			:: doneChan.async_send!0;
			:: doneChan.sync!false,0 -> 
				doneChan.sending?state
			fi;
			goto stop_process
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi
		fi;
		

		if
		:: true -> 
			

			if
			:: errChan.async_send!0;
			:: errChan.sync!false,0 -> 
				errChan.sending?state
			fi
		:: true;
		fi;
		for30_end: skip
	od;
	for30_exit: skip;
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

