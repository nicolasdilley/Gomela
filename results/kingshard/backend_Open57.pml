#define Open_db_maxConnNum  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example466400007/backend/db.go
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
	int db_maxConnNum = Open_db_maxConnNum;
	Chandef db_idleConns;
	bool state = false;
	Chandef db_cacheConns;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: db_maxConnNum > 0 -> 
		db_idleConns.size = db_maxConnNum;
		run AsyncChan(db_idleConns)
	:: else -> 
		run sync_monitor(db_idleConns)
	fi;
	
	if
	:: db_maxConnNum > 0 -> 
		db_cacheConns.size = db_maxConnNum;
		run AsyncChan(db_cacheConns)
	:: else -> 
		run sync_monitor(db_cacheConns)
	fi;
	
	if
	:: 0 != -2 && db_maxConnNum-1 != -3 -> 
				for(i : 0.. db_maxConnNum-1) {
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				
				if
				:: db_cacheConns.async_send!0;
				:: db_cacheConns.sync!0 -> 
					db_cacheConns.sending?0
				fi
			:: true -> 
				
				if
				:: db_idleConns.async_send!0;
				:: db_idleConns.sync!0 -> 
					db_idleConns.sending?0
				fi
			:: true -> 
				
				if
				:: db_idleConns.async_send!0;
				:: db_idleConns.sync!0 -> 
					db_idleConns.sending?0
				fi
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				
				if
				:: db_cacheConns.async_send!0;
				:: db_cacheConns.sync!0 -> 
					db_cacheConns.sending?0
				fi
			:: true -> 
				
				if
				:: db_idleConns.async_send!0;
				:: db_idleConns.sync!0 -> 
					db_idleConns.sending?0
				fi
			:: true -> 
				
				if
				:: db_idleConns.async_send!0;
				:: db_idleConns.sync!0 -> 
					db_idleConns.sending?0
				fi
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
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

