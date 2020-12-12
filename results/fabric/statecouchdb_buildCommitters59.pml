#define buildCommitters_namespaces  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example424524390/core/ledger/kvledger/txmgmt/statedb/statecouchdb/commit_handling.go
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
	Chandef errsChan;
	Wgdef wg;
	int i;
	Chandef nsCommittersChan;
	int namespaces = buildCommitters_namespaces;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: namespaces > 0 -> 
		nsCommittersChan.size = namespaces;
		run AsyncChan(nsCommittersChan)
	:: else -> 
		run sync_monitor(nsCommittersChan)
	fi;
	
	if
	:: namespaces > 0 -> 
		errsChan.size = namespaces;
		run AsyncChan(errsChan)
	:: else -> 
		run sync_monitor(errsChan)
	fi;
		for(i : 0.. namespaces-1) {
for10:		wg.Add!1;
		run Anonymous0(nsCommittersChan,errsChan,wg)
	};
	wg.Wait?0;
	do
	:: errsChan.async_rcv?0 -> 
		goto stop_process
	:: errsChan.sync?0 -> 
		goto stop_process
	:: true -> 
		
		if
		:: 0 != -2 && namespaces-1 != -3 -> 
						for(i : 0.. namespaces-1) {
for20:				
				if
				:: nsCommittersChan.async_rcv?0;
				:: nsCommittersChan.sync?0;
				fi
			}
		:: else -> 
			do
			:: true -> 
for20:				
				if
				:: nsCommittersChan.async_rcv?0;
				:: nsCommittersChan.sync?0;
				fi
			:: true -> 
				break
			od
		fi;
for20_exit:		break
	od;
	goto stop_process;
	errsChan.closing!true;
	nsCommittersChan.closing!true
stop_process:}

proctype Anonymous0(Chandef nsCommittersChan;Chandef errsChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errsChan.async_send!0;
		:: errsChan.sync!0 -> 
			errsChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: nsCommittersChan.async_send!0;
	:: nsCommittersChan.sync!0 -> 
		nsCommittersChan.sending?0
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

