
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example357275674/test/helpers.go
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
	Chandef stopCh;
	Chandef matchCh;
	Chandef errCh;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		errCh.size = 1;
		run AsyncChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	

	if
	:: 1 > 0 -> 
		matchCh.size = 1;
		run AsyncChan(matchCh)
	:: else -> 
		run sync_monitor(matchCh)
	fi;
	

	if
	:: 1 > 0 -> 
		stopCh.size = 1;
		run AsyncChan(stopCh)
	:: else -> 
		run sync_monitor(stopCh)
	fi;
	run go_Anonymous0(errCh,matchCh,stopCh);
	do
	:: matchCh.async_rcv?state,num_msgs -> 
		break
	:: matchCh.sync?state,num_msgs -> 
		break
	:: errCh.async_rcv?state,num_msgs -> 
		break
	:: errCh.sync?state,num_msgs -> 
		break
	:: true -> 
		stopCh.closing!true;
		break
	od
stop_process:skip
}

proctype go_Anonymous0(Chandef errCh;Chandef matchCh;Chandef stopCh) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		do
		:: stopCh.async_rcv?state,num_msgs -> 
			goto stop_process
		:: stopCh.sync?state,num_msgs -> 
			goto stop_process
		:: true;
		od;
		

		if
		:: true -> 
			

			if
			:: errCh.async_send!0;
			:: errCh.sync!false,0 -> 
				errCh.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			matchCh.closing!true;
			goto stop_process
		:: true;
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
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

