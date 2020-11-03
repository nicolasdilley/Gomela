#define ListFiles_files 0
#define ListFiles_entries 0
#define lb_for444_2  -1
#define ub_for444_3  -1
#define lb_for492_4  -1
#define ub_for492_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example402139567/src/duplicacy_gcdstorage.go
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
	bool state = false;
	int entries = ListFiles_entries;
	int files = ListFiles_files;
	int i;
	
	if
	:: lb_for444_2 != -1 && ub_for444_3 != -1 -> 
				for(i : lb_for444_2.. ub_for444_3) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. files-1) {
for20:
		};
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			
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
						for(i : 0.. entries-1) {
for30:
			};
			goto stop_process
		:: true -> 
			Chandef errorChannel;
			run sync_monitor(errorChannel);
			Chandef directoryChannel;
			run sync_monitor(directoryChannel);
						for(i : lb_for492_4.. ub_for492_5) {
for40:				
				if
				:: true -> 
					run Anonymous0(errorChannel,directoryChannel)
				:: true;
				fi;
				
				if
				:: true -> 
					do
					:: errorChannel.async_rcv?0 -> 
						goto stop_process
					:: errorChannel.sync?0 -> 
						goto stop_process
					:: directoryChannel.async_rcv?0 -> 
						break
					:: directoryChannel.sync?0 -> 
						break
					od
				:: true;
				fi
			};
for40_exit:			goto stop_process
		:: true -> 
			Chandef errorChannel;
			run sync_monitor(errorChannel);
			Chandef directoryChannel;
			run sync_monitor(directoryChannel);
						for(i : lb_for492_4.. ub_for492_5) {
for40:				
				if
				:: true -> 
					run Anonymous0(errorChannel,directoryChannel)
				:: true;
				fi;
				
				if
				:: true -> 
					do
					:: errorChannel.async_rcv?0 -> 
						goto stop_process
					:: errorChannel.sync?0 -> 
						goto stop_process
					:: directoryChannel.async_rcv?0 -> 
						break
					:: directoryChannel.sync?0 -> 
						break
					od
				:: true;
				fi
			};
for40_exit:			goto stop_process
		fi
	fi
stop_process:}

proctype Anonymous0(Chandef errorChannel;Chandef directoryChannel) {
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
		
		if
		:: errorChannel.async_send!0;
		:: errorChannel.sync!0 -> 
			errorChannel.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
		for(i : 0.. entries-1) {
for41:		
		if
		:: true -> 
			
			if
			:: directoryChannel.async_send!0;
			:: directoryChannel.sync!0 -> 
				directoryChannel.sending?0
			fi
		:: true -> 
			
			if
			:: directoryChannel.async_send!0;
			:: directoryChannel.sync!0 -> 
				directoryChannel.sending?0
			fi
		fi
	};
	
	if
	:: directoryChannel.async_send!0;
	:: directoryChannel.sync!0 -> 
		directoryChannel.sending?0
	fi;
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


