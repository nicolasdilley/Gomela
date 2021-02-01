#define Open_db_maxConnNum  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example961348362/backend/db.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef db_cacheConns;
	Chandef db_idleConns;
	int num_msgs = 0;
	bool state = false;
	int i;
	int db_maxConnNum = Open_db_maxConnNum;
	

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
			for10610: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: db_cacheConns.async_send!0;
				:: db_cacheConns.sync!false,0 -> 
					db_cacheConns.sending?state
				fi
			:: true -> 
				

				if
				:: db_idleConns.async_send!0;
				:: db_idleConns.sync!false,0 -> 
					db_idleConns.sending?state
				fi
			fi;
			for10_end610: skip
		};
		for10_exit610: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: db_cacheConns.async_send!0;
				:: db_cacheConns.sync!false,0 -> 
					db_cacheConns.sending?state
				fi
			:: true -> 
				

				if
				:: db_idleConns.async_send!0;
				:: db_idleConns.sync!false,0 -> 
					db_idleConns.sending?state
				fi
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto stop_process
stop_process:skip
}


 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}
