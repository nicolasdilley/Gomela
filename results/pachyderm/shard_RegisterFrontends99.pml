
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example882693109/src/client/pkg/shard/sharder.go
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
	int i;
	Chandef internalCancel;
	Chandef versionChan;
	Wgdef wg;
	bool state = false;
	run sync_monitor(versionChan);
	run sync_monitor(internalCancel);
	run wgMonitor(wg);
	wg.Add!3;
	run Anonymous0(versionChan,internalCancel,wg);
	run Anonymous1(versionChan,internalCancel,wg);
	run Anonymous2(versionChan,internalCancel,wg);
	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_announceFrontends0 = [0] of {int};
	run announceFrontends(versionChan,internalCancel,child_announceFrontends0);
	child_announceFrontends0?0;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_runFrontends0 = [0] of {int};
	run runFrontends(versionChan,internalCancel,frontends,child_runFrontends0);
	child_runFrontends0?0;
stop_process:	wg.Add!-1
}
proctype Anonymous2(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: internalCancel.async_rcv?0;
	:: internalCancel.sync?0;
	fi;
stop_process:	wg.Add!-1
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

