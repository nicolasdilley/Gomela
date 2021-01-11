#define EnsureOrder_n  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example163393137/tsdb/index/postings.go
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
	Chandef workc;
	bool state = false;
	int i;
	int e = -2;
	int p_m = -2;
	int n = EnsureOrder_n;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(workc);
	run wgMonitor(wg);
	wg.Add!n;
		for(i : 0.. n-1) {
		for10: skip;
		run go_Anonymous0(workc,wg);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: p_m-1 != -3 -> 
				for(i : 0.. p_m-1) {
			for20: skip;
			

			if
			:: e-1 != -3 -> 
								for(i : 0.. e-1) {
					for21: skip;
					

					if
					:: workc.async_send!0;
					:: workc.sync!0 -> 
						workc.sending?0
					fi;
					for21_end: skip
				};
				for21_exit: skip
			:: else -> 
				do
				:: true -> 
					for21147: skip;
					

					if
					:: workc.async_send!0;
					:: workc.sync!0 -> 
						workc.sending?0
					fi;
					for21_end147: skip
				:: true -> 
					break
				od;
				for21_exit147: skip
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20148: skip;
			

			if
			:: e-1 != -3 -> 
								for(i : 0.. e-1) {
					for21148: skip;
					

					if
					:: workc.async_send!0;
					:: workc.sync!0 -> 
						workc.sending?0
					fi;
					for21_end148: skip
				};
				for21_exit148: skip
			:: else -> 
				do
				:: true -> 
					for21147148: skip;
					

					if
					:: workc.async_send!0;
					:: workc.sync!0 -> 
						workc.sending?0
					fi;
					for21_end147148: skip
				:: true -> 
					break
				od;
				for21_exit147148: skip
			fi;
			for20_end148: skip
		:: true -> 
			break
		od;
		for20_exit148: skip
	fi;
	workc.closing!true;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Chandef workc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: workc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: workc.async_rcv?0;
			:: workc.sync?0;
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

