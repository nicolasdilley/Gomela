#define InstallLock_maxWorkers  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example223081060/gxutil/pm.go
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
	chan child_installLock0 = [0] of {int};
	Wgdef wg;
	Chandef workers;
	bool state = false;
	int i;
	int maxWorkers = InstallLock_maxWorkers;
	

	if
	:: maxWorkers > 0 -> 
		workers.size = maxWorkers;
		run AsyncChan(workers)
	:: else -> 
		run sync_monitor(workers)
	fi;
	run wgMonitor(wg);
		for(i : 0.. maxWorkers-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(workers,wg);
		for10_end: skip
	};
	for10_exit: skip;
	do
	:: true -> 
		for20: skip;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		run installLock(workers,child_installLock0);
		child_installLock0?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		for20_end: skip
	od;
	for20_exit: skip;
	workers.closing!true;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef workers;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: workers.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: workers.async_rcv?0;
			:: workers.sync?0;
			fi;
			for11: skip;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	wg.Add!-1;
	stop_process: skip
}
proctype installLock(Chandef workers;chan child) {
	bool closed; 
	int i;
	bool state;
	int langdeps=3;
	int lck_Deps=1;
	

	if
	:: lck_Deps-1 != -3 -> 
				for(i : 0.. lck_Deps-1) {
			for21: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: langdeps-1 != -3 -> 
								for(i : 0.. langdeps-1) {
					for22: skip;
					

					if
					:: workers.async_send!0;
					:: workers.sync!0 -> 
						workers.sending?0
					fi;
					for22_end: skip
				};
				for22_exit: skip
			:: else -> 
				do
				:: true -> 
					for221613: skip;
					

					if
					:: workers.async_send!0;
					:: workers.sync!0 -> 
						workers.sending?0
					fi;
					for22_end1613: skip
				:: true -> 
					break
				od;
				for22_exit1613: skip
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for211614: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: langdeps-1 != -3 -> 
								for(i : 0.. langdeps-1) {
					for221614: skip;
					

					if
					:: workers.async_send!0;
					:: workers.sync!0 -> 
						workers.sending?0
					fi;
					for22_end1614: skip
				};
				for22_exit1614: skip
			:: else -> 
				do
				:: true -> 
					for2216131614: skip;
					

					if
					:: workers.async_send!0;
					:: workers.sync!0 -> 
						workers.sending?0
					fi;
					for22_end16131614: skip
				:: true -> 
					break
				od;
				for22_exit16131614: skip
			fi;
			for21_end1614: skip
		:: true -> 
			break
		od;
		for21_exit1614: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
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


