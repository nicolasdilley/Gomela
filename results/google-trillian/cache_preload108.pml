#define preload_subtrees  3
#define preload_s_populateConcurrency  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example780332040/storage/cache/subtree_cache.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
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
	Chandef workTokens;
	Chandef ch;
	int num_msgs = 0;
	bool state = false;
	int i;
	int s_populateConcurrency = preload_s_populateConcurrency;
	int subtrees = preload_subtrees;
	

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
		goto stop_process
	:: true;
	fi;
	

	if
	:: subtrees > 0 -> 
		ch.size = subtrees;
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
			for302096: skip;
			

			if
			:: workTokens.async_send!0;
			:: workTokens.sync!false,0 -> 
				workTokens.sending?state
			fi;
			for30_end2096: skip
		};
		for30_exit2096: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: workTokens.async_send!0;
			:: workTokens.sync!false,0 -> 
				workTokens.sending?state
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	run wgMonitor(wg);
		for(i : 0.. subtrees-1) {
		for40: skip;
		wg.Add!1;
		run go_Anonymous0(ch,workTokens,wg);
		for40_end: skip
	};
	for40_exit: skip;
	run go_Anonymous1(ch,workTokens,wg);
	do
	:: true -> 
		

		if
		:: ch.async_rcv?state,num_msgs;
		:: ch.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for50: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for50_end: skip
		fi
	od;
	for50_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef ch;Chandef workTokens;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: workTokens.async_rcv?state,num_msgs;
	:: workTokens.sync?state,num_msgs;
	fi;
	

	if
	:: ch.async_send!0;
	:: ch.sync!false,0 -> 
		ch.sending?state
	fi;
	stop_process: skip;
	

	if
	:: workTokens.async_send!0;
	:: workTokens.sync!false,0 -> 
		workTokens.sending?state
	fi;
	wg.Add!-1
}
proctype go_Anonymous1(Chandef ch;Chandef workTokens;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Wait?0;
	ch.closing!true;
	workTokens.closing!true;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
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

