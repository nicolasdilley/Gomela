#define batchGetUserIndex_runtime_NumCPU37919  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example138612200/core/keyserver/keyserver.go
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
	Chandef results;
	Chandef uIDs;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(uIDs);
	run sync_monitor(results);
	run go_Anonymous0(uIDs,results);
	run go_Anonymous1(uIDs,results);
	do
	:: results.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi;
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef uIDs;Chandef results) {
	bool closed; 
	int i;
	bool state;
	int userIDs = -2;
	

	if
	:: userIDs-1 != -3 -> 
				for(i : 0.. userIDs-1) {
			for10: skip;
			

			if
			:: uIDs.async_send!0;
			:: uIDs.sync!0 -> 
				uIDs.sending?0
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for101886: skip;
			

			if
			:: uIDs.async_send!0;
			:: uIDs.sync!0 -> 
				uIDs.sending?0
			fi;
			for10_end1886: skip
		:: true -> 
			break
		od;
		for10_exit1886: skip
	fi;
	stop_process: skip;
	uIDs.closing!true
}
proctype go_Anonymous1(Chandef uIDs;Chandef results) {
	bool closed; 
	int i;
	bool state;
	Wgdef wg;
	int runtime_NumCPU37919 = batchGetUserIndex_runtime_NumCPU37919;
	run wgMonitor(wg);
		for(i : 0.. runtime_NumCPU37919-1) {
		for20: skip;
		wg.Add!1;
		run go_Anonymous2(uIDs,results,wg);
		for20_end: skip
	};
	for20_exit: skip;
	stop_process: skip;
	wg.Wait?0;
	results.closing!true
}
proctype go_Anonymous2(Chandef uIDs;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: uIDs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: uIDs.async_rcv?0;
			:: uIDs.sync?0;
			fi;
			for21: skip;
			

			if
			:: results.async_send!0;
			:: results.sync!0 -> 
				results.sending?0
			fi;
			for21_end: skip
		fi
	od;
	for21_exit: skip;
	stop_process: skip;
	wg.Add!-1
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

