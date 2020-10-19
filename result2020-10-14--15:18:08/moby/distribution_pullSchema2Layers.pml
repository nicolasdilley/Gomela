#define pullSchema2Layers_layers  60
#define pullSchema2Layers_descriptors  60
#define pullSchema2Layers_downloadedRootFS_DiffIDs  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example692551345/distribution/pull_v2.go
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
	int downloadedRootFS_DiffIDs = pullSchema2Layers_downloadedRootFS_DiffIDs;
	Chandef layerErrChan;
	Chandef configChan;
	int layers = pullSchema2Layers_layers;
	bool state = false;
	Chandef configErrChan;
	Chandef downloadsDone;
	int descriptors = pullSchema2Layers_descriptors;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. layers) {
for10:
	};
	
	if
	:: 1 > 0 -> 
		configChan.size = 1;
		run emptyChan(configChan)
	:: else -> 
		run sync_monitor(configChan)
	fi;
	
	if
	:: 1 > 0 -> 
		configErrChan.size = 1;
		run emptyChan(configErrChan)
	:: else -> 
		run sync_monitor(configErrChan)
	fi;
	
	if
	:: 1 > 0 -> 
		layerErrChan.size = 1;
		run emptyChan(layerErrChan)
	:: else -> 
		run sync_monitor(layerErrChan)
	fi;
	run sync_monitor(downloadsDone);
	run Anonymous0(configChan,configErrChan,layerErrChan,downloadsDone);
	
	if
	:: true -> 
		chan child_distributionreceiveConfig0 = [0] of {int};
		run distributionreceiveConfig(configChan,configErrChan,child_distributionreceiveConfig0);
		child_distributionreceiveConfig0?0;
		
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
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
				for(i : 1.. descriptors) {
for20:
		}
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous2(configChan,configErrChan,layerErrChan,downloadsDone)
	:: true -> 
		downloadsDone.closing!true
	:: true -> 
		downloadsDone.closing!true
	fi;
	
	if
	:: true -> 
		chan child_distributionreceiveConfig1 = [0] of {int};
		run distributionreceiveConfig(configChan,configErrChan,child_distributionreceiveConfig1);
		child_distributionreceiveConfig1?0;
		
		if
		:: true -> 
			do
			:: downloadsDone.async_rcv?0 -> 
				break
			:: downloadsDone.sync?0 -> 
				break
			:: layerErrChan.async_rcv?0 -> 
				break
			:: layerErrChan.sync?0 -> 
				break
			od;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	do
	:: downloadsDone.async_rcv?0 -> 
		break
	:: downloadsDone.sync?0 -> 
		break
	:: layerErrChan.async_rcv?0 -> 
		goto stop_process
	:: layerErrChan.sync?0 -> 
		goto stop_process
	od;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 1.. downloadedRootFS_DiffIDs) {
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
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef configChan;Chandef configErrChan;Chandef layerErrChan;Chandef downloadsDone) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: configErrChan.async_send!0;
		:: configErrChan.sync!0 -> 
			configErrChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: configChan.async_send!0;
	:: configChan.sync!0 -> 
		configChan.sending?0
	fi;
stop_process:
}
proctype distributionreceiveConfig(Chandef configChan;Chandef errChan;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: configChan.async_rcv?0 -> 
		
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
	:: configChan.sync?0 -> 
		
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
	:: errChan.async_rcv?0 -> 
		goto stop_process
	:: errChan.sync?0 -> 
		goto stop_process
	od;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef configChan;Chandef configErrChan;Chandef layerErrChan;Chandef downloadsDone) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: layerErrChan.async_send!0;
		:: layerErrChan.sync!0 -> 
			layerErrChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	downloadsDone.closing!true;
stop_process:
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

