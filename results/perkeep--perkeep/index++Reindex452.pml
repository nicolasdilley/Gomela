#define Reindex_reindexMaxProcs_v  3

// https://github.com/perkeep/perkeep/blob/40f12e532cba9a2b236a413d486c7ab0a6768672/pkg/index/index.go#L452
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
	Chandef enumErr;
	Chandef blobc;
	int num_msgs = 0;
	bool state = false;
	int i;
	int reindexMaxProcs_v = Reindex_reindexMaxProcs_v;
	

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 32 > 0 -> 
		blobc.size = 32;
		run AsyncChan(blobc)
	:: else -> 
		run sync_monitor(blobc)
	fi;
	

	if
	:: 1 > 0 -> 
		enumErr.size = 1;
		run AsyncChan(enumErr)
	:: else -> 
		run sync_monitor(enumErr)
	fi;
	run go_Anonymous0(blobc,enumErr);
	run wgMonitor(wg);
		for(i : 0.. reindexMaxProcs_v-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous1(blobc,enumErr,wg);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: enumErr.async_rcv?state,num_msgs;
	:: enumErr.sync?state,num_msgs;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Wait?0;
	

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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef blobc;Chandef enumErr) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: enumErr.async_send!0;
	:: enumErr.sync!false,0 -> 
		enumErr.sending?state
	fi;
	stop_process: skip;
	blobc.closing!true
}
proctype go_Anonymous1(Chandef blobc;Chandef enumErr;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: blobc.async_rcv?state,num_msgs;
		:: blobc.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	stop_process: skip;
	wg.Add!-1
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

