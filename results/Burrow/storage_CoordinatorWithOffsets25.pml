
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example497236396/core/internal/storage/fixtures.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef coordinator_running;
	int i;
	Chandef coordinator_App_StorageChannel;
	bool state = false;
	run wgMonitor(coordinator_running);
	run sync_monitor(coordinator_App_StorageChannel);
	
	if
	:: coordinator_App_StorageChannel.async_send!0;
	:: coordinator_App_StorageChannel.sync!0 -> 
		coordinator_App_StorageChannel.sending?0
	fi;
	
	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
for10:			
			if
			:: coordinator_App_StorageChannel.async_send!0;
			:: coordinator_App_StorageChannel.sync!0 -> 
				coordinator_App_StorageChannel.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: coordinator_App_StorageChannel.async_send!0;
			:: coordinator_App_StorageChannel.sync!0 -> 
				coordinator_App_StorageChannel.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
for20:			
			if
			:: coordinator_App_StorageChannel.async_send!0;
			:: coordinator_App_StorageChannel.sync!0 -> 
				coordinator_App_StorageChannel.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: coordinator_App_StorageChannel.async_send!0;
			:: coordinator_App_StorageChannel.sync!0 -> 
				coordinator_App_StorageChannel.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
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

