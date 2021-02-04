#define uploadFileInChunks_chunkCount  0
#define uploadFileInChunks_worker_options_concurrenctChunks  1
#define ub_for391_2  0

// https://github.com/chrislusf/seaweedfs/blob/e439b65e387609b2a761d9a976c0efc44060dff5/weed/command/filer_copy.go#L378
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
	Chandef concurrentChunks;
	Chandef chunksChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int worker_options_concurrenctChunks = uploadFileInChunks_worker_options_concurrenctChunks;
	int chunkCount = uploadFileInChunks_chunkCount;
	

	if
	:: chunkCount > 0 -> 
		chunksChan.size = chunkCount;
		run AsyncChan(chunksChan)
	:: else -> 
		run sync_monitor(chunksChan)
	fi;
	

	if
	:: worker_options_concurrenctChunks > 0 -> 
		concurrentChunks.size = worker_options_concurrenctChunks;
		run AsyncChan(concurrentChunks)
	:: else -> 
		run sync_monitor(concurrentChunks)
	fi;
	run wgMonitor(wg);
		for(i : 0.. ub_for391_2) {
		for10: skip;
		wg.Add!1;
		

		if
		:: concurrentChunks.async_send!0;
		:: concurrentChunks.sync!false,0 -> 
			concurrentChunks.sending?state
		fi;
		run go_Anonymous0(chunksChan,concurrentChunks,wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	chunksChan.closing!true;
	do
	:: true -> 
		

		if
		:: chunksChan.async_rcv?state,num_msgs;
		:: chunksChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	

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

proctype go_Anonymous0(Chandef chunksChan;Chandef concurrentChunks;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	:: chunksChan.async_send!0;
	:: chunksChan.sync!false,0 -> 
		chunksChan.sending?state
	fi;
	stop_process: skip;
	

	if
	:: concurrentChunks.async_rcv?state,num_msgs;
	:: concurrentChunks.sync?state,num_msgs;
	fi;
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

