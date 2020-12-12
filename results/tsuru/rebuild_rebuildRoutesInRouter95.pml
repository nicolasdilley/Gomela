#define rebuildRoutesInRouter_allPrefixes  ??
#define rebuildRoutesInRouter_allPrefixes_Sorted20525  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example055123847/router/rebuild/rebuild.go
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
	int allPrefixes_Sorted20525 = rebuildRoutesInRouter_allPrefixes_Sorted20525;
	Wgdef wg;
	Chandef resultCh;
	int toRemove = -2;
	bool state = false;
	Chandef errorCh;
	int appCnames = -2;
	int allPrefixes = rebuildRoutesInRouter_allPrefixes;
	int i;
	
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
		fi;
				for(i : 0.. appCnames-1) {
for10:
		};
				for(i : 0.. appCnames-1) {
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		};
				for(i : 0.. toRemove-1) {
for30:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
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
for60:		wg.Add!1;
		run Anonymous0(resultCh,errorCh,wg)
	};
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
			fi
		fi
	od;
	
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
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef resultCh;Chandef errorCh;Wgdef wg) {
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

