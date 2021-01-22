#define ProcessBufferedData_batchSize  3
#define ProcessBufferedData_workItemSize  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example567066427/cinterop/buffered_work.go
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
	Chandef writeChan;
	Chandef readChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int workItemSize = ProcessBufferedData_workItemSize;
	int batchSize = ProcessBufferedData_batchSize;
	

	if
	:: 2 > 0 -> 
		readChan.size = 2;
		run AsyncChan(readChan)
	:: else -> 
		run sync_monitor(readChan)
	fi;
	

	if
	:: 1 + batchSize / workItemSize > 0 -> 
		writeChan.size = 1 + batchSize / workItemSize;
		run AsyncChan(writeChan)
	:: else -> 
		run sync_monitor(writeChan)
	fi;
	run go_readBuffer(readChan);
	run go_writeBuffer(writeChan);
	do
	:: true -> 
		

		if
		:: readChan.async_rcv?state,num_msgs;
		:: readChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			

			if
			:: writeChan.async_send!0;
			:: writeChan.sync!false,0 -> 
				writeChan.sending?state
			fi;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	writeChan.closing!true
stop_process:skip
}

proctype go_readBuffer(Chandef copyTo) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: copyTo.async_send!0;
			:: copyTo.sync!false,0 -> 
				copyTo.sending?state
			fi
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	copyTo.closing!true
}
proctype go_writeBuffer(Chandef copyFrom) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: copyFrom.async_rcv?state,num_msgs;
		:: copyFrom.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				fi
			:: true;
			fi;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
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

