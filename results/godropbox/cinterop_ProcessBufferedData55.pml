#define ProcessBufferedData_batchSize  ??
#define ProcessBufferedData_workItemSize  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example128213725/cinterop/buffered_work.go
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
	int batchSize = ProcessBufferedData_batchSize;
	Chandef readChan;
	int i;
	Chandef writeChan;
	int workItemSize = ProcessBufferedData_workItemSize;
	bool state = false;
	
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
	run go_cinteropreadBuffer(readChan);
	run go_cinteropwriteBuffer(writeChan);
	do
	:: readChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: readChan.async_rcv?0;
			:: readChan.sync?0;
			fi;
			
			if
			:: writeChan.async_send!0;
			:: writeChan.sync!0 -> 
				writeChan.sending?0
			fi
		fi
	od;
	writeChan.closing!true
stop_process:}

proctype go_cinteropreadBuffer(Chandef copyTo) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: copyTo.async_send!0;
			:: copyTo.sync!0 -> 
				copyTo.sending?0
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for10_exit:stop_process:	copyTo.closing!true
}
proctype go_cinteropwriteBuffer(Chandef copyFrom) {
	bool closed; 
	int i;
	bool state;
	do
	:: copyFrom.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: copyFrom.async_rcv?0;
			:: copyFrom.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				fi
			:: true;
			fi
		fi
	od;
stop_process:
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

