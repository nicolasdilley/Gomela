
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example134586578/core/internal/storage/fixtures.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef coordinator_App_StorageChannel;
	Wgdef coordinator_running;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(coordinator_running);
	run sync_monitor(coordinator_App_StorageChannel);
	

	if
	:: coordinator_App_StorageChannel.async_send!0;
	:: coordinator_App_StorageChannel.sync!false,0 -> 
		coordinator_App_StorageChannel.sending?state
	fi;
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for101867: skip;
			

			if
			:: coordinator_App_StorageChannel.async_send!0;
			:: coordinator_App_StorageChannel.sync!false,0 -> 
				coordinator_App_StorageChannel.sending?state
			fi;
			for10_end1867: skip
		};
		for10_exit1867: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: coordinator_App_StorageChannel.async_send!0;
			:: coordinator_App_StorageChannel.sync!false,0 -> 
				coordinator_App_StorageChannel.sending?state
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
			for201868: skip;
			

			if
			:: coordinator_App_StorageChannel.async_send!0;
			:: coordinator_App_StorageChannel.sync!false,0 -> 
				coordinator_App_StorageChannel.sending?state
			fi;
			for20_end1868: skip
		};
		for20_exit1868: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: coordinator_App_StorageChannel.async_send!0;
			:: coordinator_App_StorageChannel.sync!false,0 -> 
				coordinator_App_StorageChannel.sending?state
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	goto stop_process
stop_process:skip
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

proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

