#define lb_for536_0  -1
#define ub_for536_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example279013930/go/datas/remote_database_handlers.go
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
	int i;
	Chandef aChangeChan;
	Chandef bChangeChan;
	Chandef stopChan;
	bool state = false;
	run sync_monitor(bChangeChan);
	run sync_monitor(aChangeChan);
	run sync_monitor(stopChan);
	run Anonymous0(aChangeChan,bChangeChan,stopChan);
	run Anonymous1(aChangeChan,bChangeChan,stopChan);
	do
	:: true -> 
for30:		
		if
		:: true -> 
			break
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
		fi
	od;
for30_exit:	goto stop_process;
	do
	:: bChangeChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: bChangeChan.async_rcv?0;
			:: bChangeChan.sync?0;
			fi
		fi
	od;
	do
	:: aChangeChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: aChangeChan.async_rcv?0;
			:: aChangeChan.sync?0;
			fi
		fi
	od;
	stopChan.closing!true
stop_process:}

proctype Anonymous0(Chandef aChangeChan;Chandef bChangeChan;Chandef stopChan) {
	bool closed; 
	int i;
	bool state;
	chan child_Diff0 = [0] of {int};
	run Diff(aChangeChan,stopChan,child_Diff0);
	child_Diff0?0;
stop_process:	aChangeChan.closing!true
}
proctype Anonymous1(Chandef aChangeChan;Chandef bChangeChan;Chandef stopChan) {
	bool closed; 
	int i;
	bool state;
	chan child_Diff0 = [0] of {int};
	run Diff(bChangeChan,stopChan,child_Diff0);
	child_Diff0?0;
stop_process:	bChangeChan.closing!true
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

