#define scanIndex_chanBufSize  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example714267106/lfs/gitscanner_index.go
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
	Chandef allRevsErr;
	int chanBufSize = scanIndex_chanBufSize;
	chan child_lfsNewStringChannelWrapper0 = [0] of {int};
	bool state = false;
	Chandef allRevsChan;
	Chandef ch;
	int i;
	
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
	:: 5 > 0 -> 
		allRevsErr.size = 5;
		run AsyncChan(allRevsErr)
	:: else -> 
		run sync_monitor(allRevsErr)
	fi;
	
	if
	:: 1 > 0 -> 
		allRevsChan.size = 1;
		run AsyncChan(allRevsChan)
	:: else -> 
		run sync_monitor(allRevsChan)
	fi;
	run lfsNewStringChannelWrapper(allRevsChan,allRevsErr,child_lfsNewStringChannelWrapper0);
	child_lfsNewStringChannelWrapper0?0;
	run Anonymous1(allRevsErr,allRevsChan,ch);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: chanBufSize > 0 -> 
		ch.size = chanBufSize;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous2(allRevsErr,allRevsChan,ch);
	do
	:: ch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype lfsNewStringChannelWrapper(Chandef stringChan;Chandef errorChan;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
stop_process:	child!0
}
proctype Anonymous1(Chandef allRevsErr;Chandef allRevsChan;Chandef ch) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: allRevsChan.async_send!0;
			:: allRevsChan.sync!0 -> 
				allRevsChan.sending?0
			fi
		:: true;
		fi
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: allRevsErr.async_send!0;
		:: allRevsErr.sync!0 -> 
			allRevsErr.sending?0
		fi
	:: true;
	fi;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: allRevsChan.async_send!0;
			:: allRevsChan.sync!0 -> 
				allRevsChan.sending?0
			fi
		:: true;
		fi
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: allRevsErr.async_send!0;
		:: allRevsErr.sync!0 -> 
			allRevsErr.sending?0
		fi
	:: true;
	fi;
	allRevsChan.closing!true;
	allRevsErr.closing!true;
stop_process:
}
proctype Anonymous2(Chandef allRevsErr;Chandef allRevsChan;Chandef ch) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for30:		do
		:: true -> 
for31:			
			if
			:: ch.async_send!0;
			:: ch.sync!0 -> 
				ch.sending?0
			fi
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi
	:: true;
	fi;
	ch.closing!true;
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

