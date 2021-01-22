#define DeleteChart_qSize  0
#define DeleteChart_allVersions  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example269990677/src/chartserver/handler_utility.go
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
	Chandef errWrapper;
	Chandef errChan;
	Chandef tokenQueue;
	int num_msgs = 0;
	bool state = false;
	int i;
	int allVersions = DeleteChart_allVersions;
	int qSize = DeleteChart_qSize;
	

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
			for10678: skip;
			

			if
			:: tokenQueue.async_send!0;
			:: tokenQueue.sync!false,0 -> 
				tokenQueue.sending?state
			fi;
			for10_end678: skip
		};
		for10_exit678: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: tokenQueue.async_send!0;
			:: tokenQueue.sync!false,0 -> 
				tokenQueue.sending?state
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 1 > 0 -> 
		errWrapper.size = 1;
		run AsyncChan(errWrapper)
	:: else -> 
		run sync_monitor(errWrapper)
	fi;
	run go_Anonymous0(tokenQueue,errChan,errWrapper);
		for(i : 0.. allVersions-1) {
		for30: skip;
		

		if
		:: tokenQueue.async_rcv?state,num_msgs;
		:: tokenQueue.sync?state,num_msgs;
		fi;
		run go_Anonymous1(tokenQueue,errChan,errWrapper);
		for30_end: skip
	};
	for30_exit: skip;
	errChan.closing!true;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef tokenQueue;Chandef errChan;Chandef errWrapper) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: errChan.async_rcv?state,num_msgs;
		:: errChan.sync?state,num_msgs;
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
	stop_process: skip;
	errWrapper.closing!true;
	

	if
	:: true -> 
		

		if
		:: errWrapper.async_send!0;
		:: errWrapper.sync!false,0 -> 
			errWrapper.sending?state
		fi
	:: true;
	fi
}
proctype go_Anonymous1(Chandef tokenQueue;Chandef errChan;Chandef errWrapper) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errChan.async_send!0;
		:: errChan.sync!false,0 -> 
			errChan.sending?state
		fi
	:: true;
	fi;
	stop_process: skip;
	

	if
	:: tokenQueue.async_send!0;
	:: tokenQueue.sync!false,0 -> 
		tokenQueue.sending?state
	fi
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

