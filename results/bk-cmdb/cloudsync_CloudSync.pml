#define lb_for39_0  -1
#define ub_for39_1  -1
#define 10  5
#define lb_for84_3  -1
#define ub_for84_4  -1
#define lb_for93_5  -1
#define ub_for93_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example745197591/src/scene_server/cloud_server/cloudsync/cloudsync.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	int i;
	chan child_processorTaskChanLoop0 = [0] of {int};
	Chandef taskChan;
	chan child_cloudsyncSyncCloudResource1 = [0] of {int};
	bool state = false;
	
	if
	:: 20 > 0 -> 
		taskChan.size = 20;
		run emptyChan(taskChan)
	:: else -> 
		run sync_monitor(taskChan)
	fi;
	run processorTaskChanLoop(taskChan,child_processorTaskChanLoop0);
	child_processorTaskChanLoop0?0;
	run cloudsyncSyncCloudResource(taskChan,child_cloudsyncSyncCloudResource1);
	child_cloudsyncSyncCloudResource1?0;
	goto stop_process
stop_process:}

proctype processorTaskChanLoop(Chandef taskChan;chan child) {
	bool closed; 
	int i;
	run Anonymous1(taskChan);
	child!0;
stop_process:
}
proctype Anonymous1(Chandef taskChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:			
			if
			:: taskChan.async_send!0;
			:: taskChan.sync!0 -> 
				taskChan.sending?0
			fi
		:: true -> 
			break
		od
	od;
for10_exit:stop_process:
}
proctype cloudsyncSyncCloudResource(Chandef taskChan;chan child) {
	bool closed; 
	int i;
	Chandef hostChan;
	
	if
	:: 10 > 0 -> 
		hostChan.size = 10;
		run emptyChan(hostChan)
	:: else -> 
		run sync_monitor(hostChan)
	fi;
		for(i : 1.. syncorNum) {
for20:		run Anonymous3(hostChan,taskChan)
	};
for20_exit:	run Anonymous4(hostChan,taskChan);
	child!0;
stop_process:
}
proctype Anonymous3(Chandef hostChan;Chandef taskChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for21:		
		if
		:: hostChan.async_rcv?0;
		:: hostChan.sync?0;
		fi
	od;
for21_exit:stop_process:
}
proctype Anonymous4(Chandef hostChan;Chandef taskChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		
		if
		:: taskChan.async_rcv?0;
		:: taskChan.sync?0;
		fi;
		
		if
		:: true -> 
			

			if
			:: true -> 
				
				if
				:: hostChan.async_send!0;
				:: hostChan.sync!0 -> 
					hostChan.sending?0
				fi
			:: true;
			fi
		:: true;
		fi
	od;
for30_exit:stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

