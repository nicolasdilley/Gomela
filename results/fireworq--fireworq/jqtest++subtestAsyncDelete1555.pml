
// https://github.com/fireworq/fireworq/blob/64920523abd7128a2ae5a7bc4f0676fb92133322/test/jobqueue/jobqueue.go#L555
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
	Chandef job;
	Chandef done;
	int num_msgs = 0;
	bool state = false;
	int i;
	run sync_monitor(done);
	run sync_monitor(job);
	run go_Anonymous0(done,job);
	

	if
	:: job.async_rcv?state,num_msgs;
	:: job.sync?state,num_msgs;
	fi;
	run go_Anonymous1(done,job);
	

	if
	:: done.async_rcv?state,num_msgs;
	:: done.sync?state,num_msgs;
	fi
stop_process:skip
}

proctype go_Anonymous0(Chandef done;Chandef job) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: job.async_send!0;
	:: job.sync!false,0 -> 
		job.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef done;Chandef job) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: done.async_send!0;
	:: done.sync!false,0 -> 
		done.sending?state
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

