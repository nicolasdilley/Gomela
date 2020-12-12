#define preload_want  ??
#define preload_s_populateConcurrency  ??
#define preload_subtrees  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example189230994/storage/cache/subtree_cache.go
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
	bool state = false;
	int want = preload_want;
	Chandef workTokens;
	int subtrees = preload_subtrees;
	Chandef ch;
	Wgdef wg;
	int s_populateConcurrency = preload_s_populateConcurrency;
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
	:: want > 0 -> 
		ch.size = want;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	
	if
	:: s_populateConcurrency > 0 -> 
		workTokens.size = s_populateConcurrency;
		run AsyncChan(workTokens)
	:: else -> 
		run sync_monitor(workTokens)
	fi;
	
	if
	:: 0 != -2 && s_populateConcurrency-1 != -3 -> 
				for(i : 0.. s_populateConcurrency-1) {
for30:			
			if
			:: workTokens.async_send!0;
			:: workTokens.sync!0 -> 
				workTokens.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: workTokens.async_send!0;
			:: workTokens.sync!0 -> 
				workTokens.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	run wgMonitor(wg);
		for(i : 0.. subtrees-1) {
for40:		wg.Add!1;
		run Anonymous0(ch,workTokens,wg)
	};
	run Anonymous1(ch,workTokens,wg);
	do
	:: ch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef ch;Chandef workTokens;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: workTokens.async_rcv?0;
	:: workTokens.sync?0;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
stop_process:	wg.Add!-1;
	
	if
	:: workTokens.async_send!0;
	:: workTokens.sync!0 -> 
		workTokens.sending?0
	fi
}
proctype Anonymous1(Chandef ch;Chandef workTokens;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	ch.closing!true;
	workTokens.closing!true;
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

