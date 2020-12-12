
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example814266388/controller/cmd/identity/main.go
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
	Chandef issuerEvent;
	int i;
	chan child_NewFsCredsWatcher0 = [0] of {int};
	Chandef stop;
	Chandef issuerError;
	Wgdef srv_serveWG;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		stop.size = 1;
		run AsyncChan(stop)
	:: else -> 
		run sync_monitor(stop)
	fi;
	do
	:: stop!0 -> 
		break
	:: true -> 
		break
	od;
	run sync_monitor(issuerEvent);
	run sync_monitor(issuerError);
	run NewFsCredsWatcher(issuerEvent,issuerError,child_NewFsCredsWatcher0);
	child_NewFsCredsWatcher0?0;
	run Anonymous1(stop,issuerEvent,issuerError);
	run Anonymous2(stop,issuerEvent,issuerError);
	run wgMonitor(srv_serveWG);
	run Anonymous3(stop,issuerEvent,issuerError);
	
	if
	:: stop.async_rcv?0;
	:: stop.sync?0;
	fi
stop_process:}

proctype NewFsCredsWatcher(Chandef updateEvent;Chandef errEvent;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
stop_process:	child!0
}
proctype Anonymous1(Chandef stop;Chandef issuerEvent;Chandef issuerError) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous2(Chandef stop;Chandef issuerEvent;Chandef issuerError) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous3(Chandef stop;Chandef issuerEvent;Chandef issuerError) {
	bool closed; 
	int i;
	bool state;
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

