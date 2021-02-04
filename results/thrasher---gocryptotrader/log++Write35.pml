#define Write_mw_writers  1

// https://github.com/thrasher/-gocryptotrader/blob/e611a7542db9b5eac6cf277719498f397e0a9c0f/log/logger_multiwriter.go#L35
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
	Chandef results;
	int num_msgs = 0;
	bool state = false;
	int i;
	int mw_writers = Write_mw_writers;
	

	if
	:: mw_writers > 0 -> 
		results.size = mw_writers;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
		for(i : 0.. mw_writers-1) {
		for10: skip;
		run go_Anonymous0(results);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: mw_writers-1 != -3 -> 
				for(i : 0.. mw_writers-1) {
			for20: skip;
			

			if
			:: results.async_rcv?state,num_msgs;
			:: results.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20306: skip;
			

			if
			:: results.async_rcv?state,num_msgs;
			:: results.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end306: skip
		:: true -> 
			break
		od;
		for20_exit306: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: ch.async_send!0;
		:: ch.sync!false,0 -> 
			ch.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: ch.async_send!0;
		:: ch.sync!false,0 -> 
			ch.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: ch.async_send!0;
	:: ch.sync!false,0 -> 
		ch.sending?state
	fi;
	stop_process: skip
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

