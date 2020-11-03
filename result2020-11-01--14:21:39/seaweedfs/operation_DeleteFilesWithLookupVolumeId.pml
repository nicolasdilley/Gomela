#define DeleteFilesWithLookupVolumeId_fileIds 1
#define DeleteFilesWithLookupVolumeId_lookupResults 1
#define DeleteFilesWithLookupVolumeId_result_Locations 0
#define DeleteFilesWithLookupVolumeId_server_to_fileIds 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example683189665/weed/operation/delete_content.go
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
	bool state = false;
	int lookupResults = DeleteFilesWithLookupVolumeId_lookupResults;
	Wgdef wg;
	int server_to_fileIds = DeleteFilesWithLookupVolumeId_server_to_fileIds;
	Chandef resultChan;
	int fileIds = DeleteFilesWithLookupVolumeId_fileIds;
	int result_Locations = DeleteFilesWithLookupVolumeId_result_Locations;
	int i;
		for(i : 0.. fileIds-1) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. lookupResults-1) {
for20:				for(i : 0.. result_Locations-1) {
for21:
		}
	};
	
	if
	:: server_to_fileIds > 0 -> 
		resultChan.size = server_to_fileIds;
		run emptyChan(resultChan)
	:: else -> 
		run sync_monitor(resultChan)
	fi;
	run wgMonitor(wg);
		for(i : 0.. server_to_fileIds-1) {
for30:		wg.Add!1;
		run Anonymous0(resultChan,wg)
	};
	wg.Wait?0;
	resultChan.closing!true;
	do
	:: resultChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: resultChan.async_rcv?0;
			:: resultChan.sync?0;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef resultChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi
		:: true;
		fi
	fi;
stop_process:	wg.Add!-1
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


