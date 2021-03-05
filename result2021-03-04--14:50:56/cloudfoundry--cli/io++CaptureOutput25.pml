
// https://github.com/cloudfoundry/cli/blob/daa64ed559dd33833ed41529fe804079041e7802/cf/util/testhelpers/io/io.go#L25
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
	run go_CaptureOutput()
stop_process:skip
}

proctype go_CaptureOutput() {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef result;
	Chandef doneWriting;
	run sync_monitor(doneWriting);
	run sync_monitor(result);
	run go_captureOutputAsyncronously(doneWriting,result);
	

	if
	:: doneWriting.async_send!0;
	:: doneWriting.sync!false,0 -> 
		doneWriting.sending?state
	fi;
	

	if
	:: result.async_rcv?state,num_msgs;
	:: result.sync?state,num_msgs;
	fi;
	goto stop_process;
	stop_process: skip;
	
}
proctype go_captureOutputAsyncronously(Chandef doneWriting;Chandef result) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		

		if
		:: doneWriting.async_rcv?state,num_msgs;
		:: doneWriting.sync?state,num_msgs;
		fi;
		
		if
		:: !state -> 
			break
		:: else;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	

	if
	:: result.async_send!0;
	:: result.sync!false,0 -> 
		result.sending?state
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

