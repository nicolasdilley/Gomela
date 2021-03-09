
// https://github.com/tendermint/tendermint/blob/62d7a5d0282f70b035b5b6ff925f4015d81216e5/p2p/test_util.go#L92
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
	Chandef doneCh;
	int num_msgs = 0;
	bool state = false;
	int i;
	run sync_monitor(doneCh);
	run go_Anonymous0(doneCh);
	run go_Anonymous1(doneCh);
	

	if
	:: doneCh.async_rcv?state,num_msgs;
	:: doneCh.sync?state,num_msgs;
	fi;
	

	if
	:: doneCh.async_rcv?state,num_msgs;
	:: doneCh.sync?state,num_msgs;
	fi
stop_process:skip
}

proctype go_Anonymous0(Chandef doneCh) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: doneCh.async_send!0;
	:: doneCh.sync!false,0 -> 
		doneCh.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef doneCh) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: doneCh.async_send!0;
	:: doneCh.sync!false,0 -> 
		doneCh.sending?state
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

