#define loadShards_dbDirs  60
#define loadShards_rpDirs  60
#define loadShards_shardDirs  60
#define loadShards_n  60
#define loadShards_s_databases  60
#define loadShards_state_indexTypes  60
#define loadShards_s_shards  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example798243311/tsdb/store.go
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
	int state_indexTypes = loadShards_state_indexTypes;
	int rpDirs = loadShards_rpDirs;
	Chandef resC;
	int n = loadShards_n;
	int i;
	int dbDirs = loadShards_dbDirs;
	int shardDirs = loadShards_shardDirs;
	int s_databases = loadShards_s_databases;
	int s_shards = loadShards_s_shards;
	bool state = false;
	run sync_monitor(resC);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. dbDirs) {
for10:		
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
				for(i : 1.. rpDirs) {
for11:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 1.. shardDirs) {
for12:				run Anonymous0(resC)
			}
		}
	};
	
	if
	:: 0 != -1 && n-1 != -1 -> 
				for(i : 0.. n-1) {
for20:			
			if
			:: resC.async_rcv?0;
			:: resC.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: resC.async_rcv?0;
			:: resC.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	resC.closing!true;
		for(i : 1.. s_databases) {
for30:		
		if
		:: true -> 
						for(i : 1.. state_indexTypes) {
for31:
			}
		:: true;
		fi
	};
		for(i : 1.. s_shards) {
for40:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef resC) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: resC.async_send!0;
		:: resC.sync!0 -> 
			resC.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: resC.async_send!0;
		:: resC.sync!0 -> 
			resC.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: resC.async_send!0;
		:: resC.sync!0 -> 
			resC.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: resC.async_send!0;
	:: resC.sync!0 -> 
		resC.sending?0
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

