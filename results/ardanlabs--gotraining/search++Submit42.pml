#define Submit_searchers  3

// https://github.com/ardanlabs/gotraining/blob/2a8609213c14c6f4a048c95daad0bc31ba5f4db1/topics/go/profiling/project/search/search.go#L42
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
	int searchers = Submit_searchers;
	run sync_monitor(results);
		for(i : 0.. searchers-1) {
		for10: skip;
		run go_Search(results);
		for10_end: skip
	};
	for10_exit: skip;
		for(i : 0.. searchers-1) {
		for20: skip;
		

		if
		:: true -> 
			run go_Anonymous1(results);
			goto for20_end
		:: true;
		fi;
		

		if
		:: results.async_rcv?state,num_msgs;
		:: results.sync?state,num_msgs;
		fi;
		for20_end: skip
	};
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Search(Chandef found) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: found.async_send!0;
	:: found.sync!false,0 -> 
		found.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef results) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: results.async_rcv?state,num_msgs;
	:: results.sync?state,num_msgs;
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

