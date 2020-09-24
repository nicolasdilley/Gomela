
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example376173692/core/container/inproccontroller/inproccontroller.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	Chandef ccchan;
	Chandef peerRcvCCSend;
	int i;
	Chandef ccRcvPeerSend;
	Chandef ccsupportchan;
	bool state = false;
	run sync_monitor(peerRcvCCSend);
	run sync_monitor(ccRcvPeerSend);
	
	if
	:: 1 > 0 -> 
		ccchan.size = 1;
		run emptyChan(ccchan)
	:: else -> 
		run sync_monitor(ccchan)
	fi;
	
	if
	:: 1 > 0 -> 
		ccsupportchan.size = 1;
		run emptyChan(ccsupportchan)
	:: else -> 
		run sync_monitor(ccsupportchan)
	fi;
	run Anonymous0(peerRcvCCSend,ccRcvPeerSend,ccchan,ccsupportchan);
	run Anonymous1(peerRcvCCSend,ccRcvPeerSend,ccchan,ccsupportchan);
	do
	:: ccchan.async_rcv?0 -> 
		peerRcvCCSend.closing!true;
		break
	:: ccchan.sync?0 -> 
		peerRcvCCSend.closing!true;
		break
	:: ccsupportchan.async_rcv?0 -> 
		ccRcvPeerSend.closing!true;
		break
	:: ccsupportchan.sync?0 -> 
		ccRcvPeerSend.closing!true;
		break
	:: true -> 
		ccRcvPeerSend.closing!true;
		peerRcvCCSend.closing!true
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef peerRcvCCSend;Chandef ccRcvPeerSend;Chandef ccchan;Chandef ccsupportchan) {
	bool closed; 
	int i;
	ccchan.closing!true;
stop_process:
}
proctype inproccontrollernewInProcStream(Chandef recv;Chandef send;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef peerRcvCCSend;Chandef ccRcvPeerSend;Chandef ccchan;Chandef ccsupportchan) {
	bool closed; 
	int i;
	chan child_inproccontrollernewInProcStream0 = [0] of {int};
	run inproccontrollernewInProcStream(peerRcvCCSend,ccRcvPeerSend,child_inproccontrollernewInProcStream0);
	child_inproccontrollernewInProcStream0?0;
	ccsupportchan.closing!true;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

