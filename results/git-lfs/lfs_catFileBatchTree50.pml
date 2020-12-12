#define catFileBatchTree_chanBufSize  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example714267106/lfs/gitscanner_tree.go
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
	Chandef errchan;
	bool state = false;
	int chanBufSize = catFileBatchTree_chanBufSize;
	Chandef pointers;
	chan child_lfsNewPointerChannelWrapper0 = [0] of {int};
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: chanBufSize > 0 -> 
		pointers.size = chanBufSize;
		run AsyncChan(pointers)
	:: else -> 
		run sync_monitor(pointers)
	fi;
	
	if
	:: 10 > 0 -> 
		errchan.size = 10;
		run AsyncChan(errchan)
	:: else -> 
		run sync_monitor(errchan)
	fi;
	run Anonymous0(pointers,errchan);
	run lfsNewPointerChannelWrapper(pointers,errchan,child_lfsNewPointerChannelWrapper0);
	child_lfsNewPointerChannelWrapper0?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef pointers;Chandef errchan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: pointers.async_send!0;
			:: pointers.sync!0 -> 
				pointers.sending?0
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: errchan.async_send!0;
			:: errchan.sync!0 -> 
				errchan.sending?0
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: errchan.async_send!0;
			:: errchan.sync!0 -> 
				errchan.sending?0
			fi
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errchan.async_send!0;
		:: errchan.sync!0 -> 
			errchan.sending?0
		fi
	:: true;
	fi;
	pointers.closing!true;
	errchan.closing!true;
stop_process:
}
proctype lfsNewPointerChannelWrapper(Chandef pointerChan;Chandef errorChan;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
stop_process:	child!0
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

