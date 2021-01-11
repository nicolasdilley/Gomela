#define RemoveAll_maxRoutines  1
#define RemoveAll_names  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example616394530/provider/openstack/storage.go
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
	Chandef errc;
	Wgdef wg;
	Chandef toDelete;
	bool state = false;
	int i;
	int names = RemoveAll_names;
	int maxRoutines = RemoveAll_maxRoutines;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(toDelete);
	run wgMonitor(wg);
	wg.Add!maxRoutines;
	

	if
	:: names > 0 -> 
		errc.size = names;
		run AsyncChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
		for(i : 0.. maxRoutines-1) {
		for10: skip;
		run go_Anonymous0(toDelete,errc,wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	do
	:: errc.async_rcv?0 -> 
		goto stop_process
	:: errc.sync?0 -> 
		goto stop_process
	:: true;
	od;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef toDelete;Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: toDelete.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: toDelete.async_rcv?0;
			:: toDelete.sync?0;
			fi;
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: errc.async_send!0;
				:: errc.sync!0 -> 
					errc.sending?0
				fi
			:: true;
			fi;
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

