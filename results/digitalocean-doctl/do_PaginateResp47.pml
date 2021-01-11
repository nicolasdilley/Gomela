#define ub_for84_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example103802682/do/pagination.go
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
	Wgdef wg;
	Chandef fetchChan;
	bool state = false;
	int i;
	

	if
	:: 5 > 0 -> 
		fetchChan.size = 5;
		run AsyncChan(fetchChan)
	:: else -> 
		run sync_monitor(fetchChan)
	fi;
	run wgMonitor(wg);
		for(i : 0.. 5 - 1-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(fetchChan,wg);
		for10_end: skip
	};
	for10_exit: skip;
	

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
	

	if
	:: 0 != -2 && ub_for84_0 != -2 -> 
				for(i : 0.. ub_for84_0) {
			for201689: skip;
			

			if
			:: fetchChan.async_send!0;
			:: fetchChan.sync!0 -> 
				fetchChan.sending?0
			fi;
			for20_end1689: skip
		};
		for20_exit1689: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: fetchChan.async_send!0;
			:: fetchChan.sync!0 -> 
				fetchChan.sending?0
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	fetchChan.closing!true;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef fetchChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: fetchChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: fetchChan.async_rcv?0;
			:: fetchChan.sync?0;
			fi;
			for11: skip;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	wg.Add!-1;
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

