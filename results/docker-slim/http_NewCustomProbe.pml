#define probe_maxConcurrentCrawlers  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example290801015/internal/app/master/inspectors/container/probes/http/custom_probe.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef probe_workers;
	int inspector_ImageInspector_DockerfileInfo_ExposedPorts = 5;
	int inspector_ContainerInfo_NetworkSettings_Ports = 5;
	int i;
	Chandef probe_doneChan;
	int probe_TargetPorts = 5;
	int availableHostPorts = 5;
	bool state = false;
	run wgMonitor(probe_workers);
	run sync_monitor(probe_doneChan);
	
	if
	:: true -> 
		Chandef probe_concurrentCrawlers;
		
		if
		:: probe_maxConcurrentCrawlers > 0 -> 
			probe_concurrentCrawlers.size = probe_maxConcurrentCrawlers;
			run emptyChan(probe_concurrentCrawlers)
		:: else -> 
			run sync_monitor(probe_concurrentCrawlers)
		fi
	:: true;
	fi;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: 0 != -1 && inspector_ImageInspector_DockerfileInfo_ExposedPorts - 1 != -1 -> 
								for(i : 0.. inspector_ImageInspector_DockerfileInfo_ExposedPorts - 1) {
for30:
				}
			:: else -> 
				do
				:: true -> 
for30:
				:: true -> 
					break
				od
			fi;
for30_exit:
		:: true;
		fi;
		do
		:: true -> 
for40:
		:: true -> 
			break
		od
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: 0 != -1 && inspector_ImageInspector_DockerfileInfo_ExposedPorts - 1 != -1 -> 
								for(i : 0.. inspector_ImageInspector_DockerfileInfo_ExposedPorts - 1) {
for30:
				}
			:: else -> 
				do
				:: true -> 
for30:
				:: true -> 
					break
				od
			fi;
for30_exit:
		:: true;
		fi;
		do
		:: true -> 
for40:
		:: true -> 
			break
		od
	fi;
	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
	od;
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

