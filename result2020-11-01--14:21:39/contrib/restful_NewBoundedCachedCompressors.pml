#define NewBoundedCachedCompressors_writersCapacity 3
#define NewBoundedCachedCompressors_readersCapacity 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example415420627/service-loadbalancer/Godeps/_workspace/src/github.com/emicklei/go-restful/compressor_cache.go
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
	Chandef b_gzipReaders;
	int i;
	int writersCapacity = NewBoundedCachedCompressors_writersCapacity;
	Chandef b_gzipWriters;
	Chandef b_zlibWriters;
	int readersCapacity = NewBoundedCachedCompressors_readersCapacity;
	bool state = false;
	
	if
	:: writersCapacity > 0 -> 
		b_gzipWriters.size = writersCapacity;
		run emptyChan(b_gzipWriters)
	:: else -> 
		run sync_monitor(b_gzipWriters)
	fi;
	
	if
	:: readersCapacity > 0 -> 
		b_gzipReaders.size = readersCapacity;
		run emptyChan(b_gzipReaders)
	:: else -> 
		run sync_monitor(b_gzipReaders)
	fi;
	
	if
	:: writersCapacity > 0 -> 
		b_zlibWriters.size = writersCapacity;
		run emptyChan(b_zlibWriters)
	:: else -> 
		run sync_monitor(b_zlibWriters)
	fi;
	
	if
	:: 0 != -1 && writersCapacity-1 != -1 -> 
				for(i : 0.. writersCapacity-1) {
for10:			
			if
			:: b_gzipWriters.async_send!0;
			:: b_gzipWriters.sync!0 -> 
				b_gzipWriters.sending?0
			fi;
			
			if
			:: b_zlibWriters.async_send!0;
			:: b_zlibWriters.sync!0 -> 
				b_zlibWriters.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: b_gzipWriters.async_send!0;
			:: b_gzipWriters.sync!0 -> 
				b_gzipWriters.sending?0
			fi;
			
			if
			:: b_zlibWriters.async_send!0;
			:: b_zlibWriters.sync!0 -> 
				b_zlibWriters.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: 0 != -1 && readersCapacity-1 != -1 -> 
				for(i : 0.. readersCapacity-1) {
for20:			
			if
			:: b_gzipReaders.async_send!0;
			:: b_gzipReaders.sync!0 -> 
				b_gzipReaders.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: b_gzipReaders.async_send!0;
			:: b_gzipReaders.sync!0 -> 
				b_gzipReaders.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
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


