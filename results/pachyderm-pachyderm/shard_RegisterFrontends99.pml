#define ub_for102_1  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example363699075/src/client/pkg/shard/sharder.go
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
	Chandef internalCancel;
	Chandef versionChan;
	bool state = false;
	int i;
	run sync_monitor(versionChan);
	run sync_monitor(internalCancel);
	run wgMonitor(wg);
	wg.Add!3;
	run go_Anonymous0(versionChan,internalCancel,wg);
	run go_Anonymous2(versionChan,internalCancel,wg);
	run go_Anonymous6(versionChan,internalCancel,wg);
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_announceFrontends0 = [0] of {int};
	run announceFrontends(versionChan,internalCancel,child_announceFrontends0);
	child_announceFrontends0?0;
	stop_process: skip;
	wg.Add!-1
}
proctype announceFrontends(Chandef versionChan;Chandef cancel;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: cancel.async_rcv?0 -> 
			goto stop_process
		:: cancel.sync?0 -> 
			goto stop_process
		:: versionChan.async_rcv?0 -> 
			break
		:: versionChan.sync?0 -> 
			break
		:: true -> 
			break
		od;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype go_Anonymous2(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_runFrontends0 = [0] of {int};
	int frontends = -2;
	run runFrontends(versionChan,internalCancel,frontends,child_runFrontends0);
	child_runFrontends0?0;
	stop_process: skip;
	wg.Add!-1
}
proctype runFrontends(Chandef versionChan;Chandef cancel;int frontends;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_WatchAll0 = [0] of {int};
	run WatchAll(cancel,child_WatchAll0);
	child_WatchAll0?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype WatchAll(Chandef cancel;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_watchAllWithoutRetry0 = [0] of {int};
		for(i : 0.. ub_for102_1) {
		for20: skip;
		run watchAllWithoutRetry(cancel,child_watchAllWithoutRetry0);
		child_watchAllWithoutRetry0?0;
		

		if
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto for21_end
				:: true;
				fi;
				

				if
				:: true -> 
					goto for21_end
				:: true;
				fi
			:: true;
			fi;
			goto stop_process
		:: true;
		fi;
		for20_end: skip
	};
	for20_exit: skip;
	stop_process: skip;
	child!0
}
proctype watchAllWithoutRetry(Chandef cancel;chan child) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	fi;
	stop_process: skip;
	child!0
}
proctype go_Anonymous6(Chandef versionChan;Chandef internalCancel;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: internalCancel.async_rcv?0;
	:: internalCancel.sync?0;
	fi;
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

