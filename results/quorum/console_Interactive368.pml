#define lb_for399_0  -1
#define ub_for399_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example440247525/console/console.go
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
	Chandef scheduler;
	int i;
	Chandef abort;
	bool state = false;
	run sync_monitor(scheduler);
	run Anonymous0(scheduler,abort);
	
	if
	:: 1 > 0 -> 
		abort.size = 1;
		run AsyncChan(abort)
	:: else -> 
		run sync_monitor(abort)
	fi;
	do
	:: abort!0 -> 
		break
	:: true -> 
		break
	od;
	do
	:: true -> 
for20:		
		if
		:: scheduler.async_send!0;
		:: scheduler.sync!0 -> 
			scheduler.sending?0
		fi;
		do
		:: abort.async_rcv?0 -> 
			goto stop_process
		:: abort.sync?0 -> 
			goto stop_process
		:: scheduler.async_rcv?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: scheduler.sync?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		od
	od;
for20_exit:
stop_process:}

proctype Anonymous0(Chandef scheduler;Chandef abort) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: scheduler.async_rcv?0;
		:: scheduler.sync?0;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: scheduler.async_send!0;
				:: scheduler.sync!0 -> 
					scheduler.sending?0
				fi
			:: true;
			fi;
			scheduler.closing!true;
			goto stop_process
		:: true;
		fi;
		
		if
		:: scheduler.async_send!0;
		:: scheduler.sync!0 -> 
			scheduler.sending?0
		fi
	od;
for10_exit:stop_process:
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

