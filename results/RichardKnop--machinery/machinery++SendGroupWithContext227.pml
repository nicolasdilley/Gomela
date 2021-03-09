#define SendGroupWithContext_group_Tasks  0
#define SendGroupWithContext_sendConcurrency  0

// https://github.com/RichardKnop/machinery/blob/47893a0e7aa31dcc73974647c0fac6d9889643a6/v2/server.go#L227
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
	Chandef done;
	Chandef pool;
	Chandef errorsChan;
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int sendConcurrency = SendGroupWithContext_sendConcurrency;
	int group_Tasks = SendGroupWithContext_group_Tasks;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	wg.Add!group_Tasks;
	

	if
	:: group_Tasks * 2 > 0 -> 
		errorsChan.size = group_Tasks * 2;
		run AsyncChan(errorsChan)
	:: else -> 
		run sync_monitor(errorsChan)
	fi;
	

	if
	:: group_Tasks-1 != -3 -> 
				for(i : 0.. group_Tasks-1) {
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: errorsChan.async_send!0;
				:: errorsChan.sync!false,0 -> 
					errorsChan.sending?state
				fi;
				goto for10_end
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10847: skip;
			

			if
			:: true -> 
				

				if
				:: errorsChan.async_send!0;
				:: errorsChan.sync!false,0 -> 
					errorsChan.sending?state
				fi;
				goto for10_end847
			:: true;
			fi;
			for10_end847: skip
		:: true -> 
			break
		od;
		for10_exit847: skip
	fi;
	

	if
	:: sendConcurrency > 0 -> 
		pool.size = sendConcurrency;
		run AsyncChan(pool)
	:: else -> 
		run sync_monitor(pool)
	fi;
	run go_Anonymous0(errorsChan,pool,wg,sendConcurrency);
		for(i : 0.. group_Tasks-1) {
		for30: skip;
		

		if
		:: true -> 
			

			if
			:: pool.async_rcv?state,num_msgs;
			:: pool.sync?state,num_msgs;
			fi
		:: true;
		fi;
		run go_Anonymous1(errorsChan,pool,wg);
		for30_end: skip
	};
	for30_exit: skip;
	run sync_monitor(done);
	run go_Anonymous2(errorsChan,pool,done,wg);
	do
	:: errorsChan.async_rcv?state,num_msgs -> 
		goto stop_process
	:: errorsChan.sync?state,num_msgs -> 
		goto stop_process
	:: done.async_rcv?state,num_msgs -> 
		goto stop_process
	:: done.sync?state,num_msgs -> 
		goto stop_process
	od
stop_process:skip
}

proctype go_Anonymous0(Chandef errorsChan;Chandef pool;Wgdef wg;int sendConcurrency) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && sendConcurrency-1 != -3 -> 
				for(i : 0.. sendConcurrency-1) {
			for20848: skip;
			

			if
			:: pool.async_send!0;
			:: pool.sync!false,0 -> 
				pool.sending?state
			fi;
			for20_end848: skip
		};
		for20_exit848: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: pool.async_send!0;
			:: pool.sync!false,0 -> 
				pool.sending?state
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef errorsChan;Chandef pool;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: pool.async_send!0;
		:: pool.sync!false,0 -> 
			pool.sending?state
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: errorsChan.async_send!0;
		:: errorsChan.sync!false,0 -> 
			errorsChan.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous2(Chandef errorsChan;Chandef pool;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Wait?0;
	

	if
	:: done.async_send!0;
	:: done.sync!false,0 -> 
		done.sending?state
	fi;
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

