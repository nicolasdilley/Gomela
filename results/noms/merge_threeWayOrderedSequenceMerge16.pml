#define lb_for34_0  -1
#define ub_for34_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example279013930/go/merge/three_way_ordered_sequence.go
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
	Chandef bChangeChan;
	chan child_mergestopAndDrain1 = [0] of {int};
	Chandef bStopChan;
	int i;
	Chandef aChangeChan;
	Chandef aStopChan;
	chan child_mergestopAndDrain0 = [0] of {int};
	bool state = false;
	run sync_monitor(bChangeChan);
	run sync_monitor(aChangeChan);
	
	if
	:: 1 > 0 -> 
		bStopChan.size = 1;
		run AsyncChan(bStopChan)
	:: else -> 
		run sync_monitor(bStopChan)
	fi;
	
	if
	:: 1 > 0 -> 
		aStopChan.size = 1;
		run AsyncChan(aStopChan)
	:: else -> 
		run sync_monitor(aStopChan)
	fi;
	run Anonymous0(aChangeChan,bChangeChan,aStopChan,bStopChan);
	run Anonymous1(aChangeChan,bChangeChan,aStopChan,bStopChan);
	do
	:: true -> 
for20:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for20_exit:	goto stop_process;
	child_mergestopAndDrain1?0;
	run mergestopAndDrain(bStopChan,bChangeChan,child_mergestopAndDrain1);
	child_mergestopAndDrain0?0;
	run mergestopAndDrain(aStopChan,aChangeChan,child_mergestopAndDrain0)
stop_process:}

proctype Anonymous0(Chandef aChangeChan;Chandef bChangeChan;Chandef aStopChan;Chandef bStopChan) {
	bool closed; 
	int i;
	bool state;
	chan child_diff0 = [0] of {int};
	run diff(aChangeChan,aStopChan,child_diff0);
	child_diff0?0;
	aChangeChan.closing!true;
stop_process:
}
proctype Anonymous1(Chandef aChangeChan;Chandef bChangeChan;Chandef aStopChan;Chandef bStopChan) {
	bool closed; 
	int i;
	bool state;
	chan child_diff0 = [0] of {int};
	run diff(bChangeChan,bStopChan,child_diff0);
	child_diff0?0;
	bChangeChan.closing!true;
stop_process:
}
proctype mergestopAndDrain(Chandef stop;Chandef drain;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
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

