
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example245190199/go/vt/throttler/throttler.go
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
	chan child_Start0 = [0] of {int};
	chan child_Start0 = [0] of {int};
	Chandef rateUpdateChan;
	Wgdef maxReplicationLagModule_wg;
	bool state = false;
	int i;
	int modules = -2;
	

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
	run wgMonitor(maxReplicationLagModule_wg);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 10 > 0 -> 
		rateUpdateChan.size = 10;
		run AsyncChan(rateUpdateChan)
	:: else -> 
		run sync_monitor(rateUpdateChan)
	fi;
	

	if
	:: modules-1 != -3 -> 
				for(i : 0.. modules-1) {
			for10: skip;
			run Start(rateUpdateChan,child_Start0);
			child_Start0?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10418: skip;
			run Start(rateUpdateChan,child_Start0);
			child_Start0?0;
			for10_end418: skip
		:: true -> 
			break
		od;
		for10_exit418: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run go_Anonymous1(rateUpdateChan);
	goto stop_process
stop_process:skip
}

proctype Start(Chandef rateUpdateChan;chan child) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	child!0
}
proctype go_Anonymous1(Chandef rateUpdateChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: rateUpdateChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: rateUpdateChan.async_rcv?0;
			:: rateUpdateChan.sync?0;
			fi;
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	stop_process: skip
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

