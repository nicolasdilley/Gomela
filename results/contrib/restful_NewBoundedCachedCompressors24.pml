#define NewBoundedCachedCompressors_writersCapacity  ??
#define NewBoundedCachedCompressors_readersCapacity  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example354162558/service-loadbalancer/Godeps/_workspace/src/github.com/emicklei/go-restful/compressor_cache.go
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
		run AsyncChan(b_gzipWriters)
	:: else -> 
		run sync_monitor(b_gzipWriters)
	fi;
	
	if
	:: readersCapacity > 0 -> 
		b_gzipReaders.size = readersCapacity;
		run AsyncChan(b_gzipReaders)
	:: else -> 
		run sync_monitor(b_gzipReaders)
	fi;
	
	if
	:: writersCapacity > 0 -> 
		b_zlibWriters.size = writersCapacity;
		run AsyncChan(b_zlibWriters)
	:: else -> 
		run sync_monitor(b_zlibWriters)
	fi;
	
	if
	:: 0 != -2 && writersCapacity-1 != -3 -> 
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
	:: 0 != -2 && readersCapacity-1 != -3 -> 
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

