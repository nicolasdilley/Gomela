#define concurrentLoadingVolumes_concurrency  0

// https://github.com/chrislusf/seaweedfs/blob/e439b65e387609b2a761d9a976c0efc44060dff5/weed/storage/disk_location.go#L136
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
	Chandef task_queue;
	int num_msgs = 0;
	bool state = false;
	int i;
	int concurrency = concurrentLoadingVolumes_concurrency;
	

	if
	:: 10 * concurrency > 0 -> 
		task_queue.size = 10 * concurrency;
		run AsyncChan(task_queue)
	:: else -> 
		run sync_monitor(task_queue)
	fi;
	run go_Anonymous0(task_queue);
	run wgMonitor(wg);
		for(i : 0.. concurrency-1) {
		for20: skip;
		wg.Add!1;
		run go_Anonymous1(task_queue,wg);
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Chandef task_queue) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int fileInfos=3;
	

	if
	:: true -> 
		

		if
		:: fileInfos-1 != -3 -> 
						for(i : 0.. fileInfos-1) {
				for10: skip;
				

				if
				:: true -> 
					goto for10_end
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: task_queue.async_send!0;
					:: task_queue.sync!false,0 -> 
						task_queue.sending?state
					fi
				:: true;
				fi;
				for10_end: skip
			};
			for10_exit: skip
		:: else -> 
			do
			:: true -> 
				for10805: skip;
				

				if
				:: true -> 
					goto for10_end805
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: task_queue.async_send!0;
					:: task_queue.sync!false,0 -> 
						task_queue.sending?state
					fi
				:: true;
				fi;
				for10_end805: skip
			:: true -> 
				break
			od;
			for10_exit805: skip
		fi
	:: true;
	fi;
	task_queue.closing!true;
	stop_process: skip
}
proctype go_Anonymous1(Chandef task_queue;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: task_queue.async_rcv?state,num_msgs;
		:: task_queue.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for21: skip;
			for21_end: skip
		fi
	od;
	for21_exit: skip;
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


