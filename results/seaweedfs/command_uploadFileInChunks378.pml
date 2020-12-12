#define uploadFileInChunks_chunkCount  ??
#define uploadFileInChunks_worker_options_concurrenctChunks  ??
#define lb_for391_2  -1
#define ub_for391_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example102359220/weed/command/filer_copy.go
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
	Chandef chunksChan;
	int worker_options_concurrenctChunks = uploadFileInChunks_worker_options_concurrenctChunks;
	Wgdef wg;
	int i;
	Chandef concurrentChunks;
	int chunkCount = uploadFileInChunks_chunkCount;
	int chunks = -2;
	bool state = false;
	
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
		for(i : lb_for391_2.. ub_for391_3) {
for10:		wg.Add!1;
		
		if
		:: concurrentChunks.async_send!0;
		:: concurrentChunks.sync!0 -> 
			concurrentChunks.sending?0
		fi;
		run Anonymous0(chunksChan,concurrentChunks,wg)
	};
for10_exit:	wg.Wait?0;
	chunksChan.closing!true;
	do
	:: chunksChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: chunksChan.async_rcv?0;
			:: chunksChan.sync?0;
			fi
		fi
	od;
	
	if
	:: true -> 
				for(i : 0.. chunks-1) {
for30:
		};
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef chunksChan;Chandef concurrentChunks;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
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
	:: chunksChan.sync!0 -> 
		chunksChan.sending?0
	fi;
stop_process:	wg.Add!-1;
	
	if
	:: concurrentChunks.async_rcv?0;
	:: concurrentChunks.sync?0;
	fi
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

