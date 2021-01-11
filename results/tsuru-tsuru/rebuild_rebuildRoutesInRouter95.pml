#define rebuildRoutesInRouter_allPrefixes  1
#define rebuildRoutesInRouter_allPrefixes_Sorted20525  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example757678981/router/rebuild/rebuild.go
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
	Chandef errorCh;
	Chandef resultCh;
	bool state = false;
	int i;
	int allPrefixes_Sorted20525 = rebuildRoutesInRouter_allPrefixes_Sorted20525;
	int allPrefixes = rebuildRoutesInRouter_allPrefixes;
	

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
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: allPrefixes > 0 -> 
		resultCh.size = allPrefixes;
		run AsyncChan(resultCh)
	:: else -> 
		run sync_monitor(resultCh)
	fi;
	

	if
	:: allPrefixes > 0 -> 
		errorCh.size = allPrefixes;
		run AsyncChan(errorCh)
	:: else -> 
		run sync_monitor(errorCh)
	fi;
	run wgMonitor(wg);
		for(i : 0.. allPrefixes_Sorted20525-1) {
		for60: skip;
		

		if
		:: true -> 
			goto for60_end
		:: true;
		fi;
		wg.Add!1;
		run go_Anonymous0(resultCh,errorCh,wg);
		for60_end: skip
	};
	for60_exit: skip;
	wg.Wait?0;
	errorCh.closing!true;
	resultCh.closing!true;
	do
	:: errorCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: errorCh.async_rcv?0;
			:: errorCh.sync?0;
			fi;
			for70: skip;
			for70_end: skip
		fi
	od;
	for70_exit: skip;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: resultCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: resultCh.async_rcv?0;
			:: resultCh.sync?0;
			fi;
			for80: skip;
			for80_end: skip
		fi
	od;
	for80_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef resultCh;Chandef errorCh;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: resultCh.async_send!0;
		:: resultCh.sync!0 -> 
			resultCh.sending?0
		fi
	:: true -> 
		

		if
		:: errorCh.async_send!0;
		:: errorCh.sync!0 -> 
			errorCh.sending?0
		fi
	:: true -> 
		

		if
		:: errorCh.async_send!0;
		:: errorCh.sync!0 -> 
			errorCh.sending?0
		fi
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

