#define targets  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example475005822/sift.go
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
	Chandef global_directoryChan;
	int i;
	Chandef global_resultsDoneChan;
	Chandef global_filesChan;
	Chandef global_resultsChan;
	int options_Cores = 5;
	bool state = false;
	
	if
	:: 256 > 0 -> 
		global_filesChan.size = 256;
		run emptyChan(global_filesChan)
	:: else -> 
		run sync_monitor(global_filesChan)
	fi;
	
	if
	:: 128 > 0 -> 
		global_directoryChan.size = 128;
		run emptyChan(global_directoryChan)
	:: else -> 
		run sync_monitor(global_directoryChan)
	fi;
	
	if
	:: 128 > 0 -> 
		global_resultsChan.size = 128;
		run emptyChan(global_resultsChan)
	:: else -> 
		run sync_monitor(global_resultsChan)
	fi;
	run sync_monitor(global_resultsDoneChan);
		for(i : 0.. options_Cores-1) {
for10:
	};
for10_exit:		for(i : 1.. targets) {
for20:		

		if
		:: true -> 
			
			if
			:: global_filesChan.async_send!0;
			:: global_filesChan.sync!0 -> 
				global_filesChan.sending?0
			fi
		:: true;
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: global_directoryChan.async_send!0;
				:: global_directoryChan.sync!0 -> 
					global_directoryChan.sending?0
				fi
			:: true -> 
				
				if
				:: global_filesChan.async_send!0;
				:: global_filesChan.sync!0 -> 
					global_filesChan.sending?0
				fi
			:: true -> 
				
				if
				:: global_filesChan.async_send!0;
				:: global_filesChan.sync!0 -> 
					global_filesChan.sending?0
				fi
			fi
		fi
	};
	global_directoryChan.closing!true;
	global_filesChan.closing!true;
	global_resultsChan.closing!true;
	
	if
	:: global_resultsDoneChan.async_rcv?0;
	:: global_resultsDoneChan.sync?0;
	fi;
	goto stop_process
stop_process:}

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

