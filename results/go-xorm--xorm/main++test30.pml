#define test_size  3

// https://github.com/go-xorm/xorm/blob/f39e5d9bfdb70c435f8649555f224c0fa4f51e54/examples/maxconnect.go#L30
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
	Chandef queue;
	int num_msgs = 0;
	bool state = false;
	int i;
	int size = test_size;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: size > 0 -> 
		queue.size = size;
		run AsyncChan(queue)
	:: else -> 
		run sync_monitor(queue)
	fi;
		for(i : 0.. size-1) {
		for10: skip;
		run go_Anonymous0(queue);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && size-1 != -3 -> 
				for(i : 0.. size-1) {
			for20766: skip;
			

			if
			:: queue.async_rcv?state,num_msgs;
			:: queue.sync?state,num_msgs;
			fi;
			for20_end766: skip
		};
		for20_exit766: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: queue.async_rcv?state,num_msgs;
			:: queue.sync?state,num_msgs;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi
stop_process:skip
}

proctype go_Anonymous0(Chandef queue) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: 0 != -2 && 10-1 != -3 -> 
						for(i : 0.. 10-1) {
				for11765: skip;
				

				if
				:: true -> 
					

					if
					:: queue.async_send!0;
					:: queue.sync!false,0 -> 
						queue.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				for11_end765: skip
			};
			for11_exit765: skip
		:: else -> 
			do
			:: true -> 
				for11: skip;
				

				if
				:: true -> 
					

					if
					:: queue.async_send!0;
					:: queue.sync!false,0 -> 
						queue.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				for11_end: skip
			:: true -> 
				break
			od;
			for11_exit: skip
		fi
	fi;
	

	if
	:: queue.async_send!0;
	:: queue.sync!false,0 -> 
		queue.sending?state
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

