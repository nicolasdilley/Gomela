#define SendGroupWithContext_group_Tasks  ??
#define SendGroupWithContext_sendConcurrency  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example309770998/v2/server.go
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
	Chandef done;
	Chandef errorsChan;
	int sendConcurrency = SendGroupWithContext_sendConcurrency;
	Wgdef wg;
	Chandef pool;
	int group_Tasks = SendGroupWithContext_group_Tasks;
	int i;
	
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
		for(i : 0.. group_Tasks-1) {
for10:		
		if
		:: true -> 
			
			if
			:: errorsChan.async_send!0;
			:: errorsChan.sync!0 -> 
				errorsChan.sending?0
			fi
		:: true;
		fi
	};
	
	if
	:: sendConcurrency > 0 -> 
		pool.size = sendConcurrency;
		run AsyncChan(pool)
	:: else -> 
		run sync_monitor(pool)
	fi;
	run Anonymous0(errorsChan,pool,done,wg);
	run sync_monitor(done);
	run Anonymous2(errorsChan,pool,done,wg);
	do
	:: errorsChan.async_rcv?0 -> 
		goto stop_process
	:: errorsChan.sync?0 -> 
		goto stop_process
	:: done.async_rcv?0 -> 
		goto stop_process
	:: done.sync?0 -> 
		goto stop_process
	od
stop_process:}

proctype Anonymous0(Chandef errorsChan;Chandef pool;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -2 && sendConcurrency-1 != -3 -> 
				for(i : 0.. sendConcurrency-1) {
for20:			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: pool.async_send!0;
			:: pool.sync!0 -> 
				pool.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:stop_process:
}
proctype Anonymous1(Chandef errorsChan;Chandef pool;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: pool.async_send!0;
		:: pool.sync!0 -> 
			pool.sending?0
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errorsChan.async_send!0;
		:: errorsChan.sync!0 -> 
			errorsChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
stop_process:	wg.Add!-1
}
proctype Anonymous2(Chandef errorsChan;Chandef pool;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi;
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

