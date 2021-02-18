
// https://github.com/kubicorn/kubicorn/blob/a2c64ce430b93e76c2a7a13b0a3dd2c3bcae748d/pkg/retry/retry.go#L49
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
	Chandef finish;
	int num_msgs = 0;
	bool state = false;
	int i;
	int r_retries = -2;
	

	if
	:: 1 > 0 -> 
		finish.size = 1;
		run AsyncChan(finish)
	:: else -> 
		run sync_monitor(finish)
	fi;
	run go_Anonymous0(finish);
	

	if
	:: 0 != -2 && r_retries-1 != -3 -> 
				for(i : 0.. r_retries-1) {
			for201120: skip;
			

			if
			:: true -> 
				goto for20_end1120
			:: true;
			fi;
			

			if
			:: finish.async_send!0;
			:: finish.sync!false,0 -> 
				finish.sending?state
			fi;
			goto stop_process;
			for20_end1120: skip
		};
		for20_exit1120: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: finish.async_send!0;
			:: finish.sync!false,0 -> 
				finish.sending?state
			fi;
			goto stop_process;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: finish.async_send!0;
	:: finish.sync!false,0 -> 
		finish.sending?state
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef finish) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: finish.async_rcv?state,num_msgs -> 
		goto stop_process
	:: finish.sync?state,num_msgs -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true;
	od;
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

