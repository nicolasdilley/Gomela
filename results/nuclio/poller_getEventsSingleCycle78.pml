#define lb_for84_0  -1
#define ub_for84_1  -1
#define lb_for93_2  -1
#define ub_for93_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example491159710/pkg/processor/trigger/poller/trigger.go
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
	Chandef eventsChan;
	bool state = false;
	run sync_monitor(eventsChan);
		for(i : lb_for84_0.. ub_for84_1) {
for10:		
		if
		:: lb_for93_2 != -2 && ub_for93_3 != -2 -> 
						for(i : lb_for93_2.. ub_for93_3) {
for11:				chan child_waitForEventBatch0 = [0] of {int};
				run waitForEventBatch(eventsChan,child_waitForEventBatch0);
				child_waitForEventBatch0?0
			}
		:: else -> 
			do
			:: true -> 
for11:				chan child_waitForEventBatch0 = [0] of {int};
				run waitForEventBatch(eventsChan,child_waitForEventBatch0);
				child_waitForEventBatch0?0
			:: true -> 
				break
			od
		fi;
for11_exit:
	};
for10_exit:
stop_process:}

proctype waitForEventBatch(Chandef eventsChan;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for140_4 != -2 && ub_for140_5 != -2 -> 
				for(i : lb_for140_4.. ub_for140_5) {
for12:			do
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for12:			do
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for12_exit:	goto stop_process;
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

