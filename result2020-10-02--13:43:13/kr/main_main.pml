#define lb_for181_0  -1
#define ub_for181_1  -1
#define lb_for208_2  -1
#define ub_for208_3  -1
#define lb_for292_4  -1
#define ub_for292_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example195902074/src/krssh/main.go
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
	Chandef notifyPrefix;
	chan child_mainstartRemoteInputFowarding2 = [0] of {int};
	chan child_mainstartRemoteOutputParsing1 = [0] of {int};
	int i;
	Chandef remoteDoneChan;
	Chandef localDoneChan;
	Chandef stopSignal;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		notifyPrefix.size = 1;
		run emptyChan(notifyPrefix)
	:: else -> 
		run sync_monitor(notifyPrefix)
	fi;
	run Anonymous0(notifyPrefix,remoteDoneChan,localDoneChan,stopSignal);
	run sync_monitor(remoteDoneChan);
	run mainstartRemoteOutputParsing(remoteDoneChan,notifyPrefix,child_mainstartRemoteOutputParsing0);
	child_mainstartRemoteOutputParsing1?0;
	run sync_monitor(localDoneChan);
	run mainstartRemoteInputFowarding(localDoneChan,child_mainstartRemoteInputFowarding2);
	child_mainstartRemoteInputFowarding2?0;
	
	if
	:: 1 > 0 -> 
		stopSignal.size = 1;
		run emptyChan(stopSignal)
	:: else -> 
		run sync_monitor(stopSignal)
	fi;
	do
	:: true -> 
for30:		do
		:: stopSignal.async_rcv?0 -> 
			goto stop_process
		:: stopSignal.sync?0 -> 
			goto stop_process
		:: localDoneChan.async_rcv?0 -> 
			goto stop_process
		:: localDoneChan.sync?0 -> 
			goto stop_process
		:: remoteDoneChan.async_rcv?0 -> 
			goto stop_process
		:: remoteDoneChan.sync?0 -> 
			goto stop_process
		od
	od;
for30_exit:
stop_process:}

proctype Anonymous0(Chandef notifyPrefix;Chandef remoteDoneChan;Chandef localDoneChan;Chandef stopSignal) {
	bool closed; 
	int i;
	
	if
	:: notifyPrefix.async_rcv?0;
	:: notifyPrefix.sync?0;
	fi;
stop_process:
}
proctype mainstartRemoteOutputParsing(Chandef doneChan;Chandef notifyPrefixChan;chan child) {
	bool closed; 
	int i;
	run Anonymous2(doneChan,notifyPrefixChan);
	child!0;
stop_process:
}
proctype maintryParse(Chandef onHostPrefix;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: onHostPrefix.async_send!0 -> 
			break
		:: onHostPrefix.sync!0 -> 
			onHostPrefix.sending?0;
			break
		:: true -> 
			break
		od
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef doneChan;Chandef notifyPrefixChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				chan child_maintryParse0 = [0] of {int};
				run maintryParse(notifyPrefixChan,child_maintryParse0);
				child_maintryParse0?0
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	od;
for10_exit:	
	if
	:: doneChan.async_send!0;
	:: doneChan.sync!0 -> 
		doneChan.sending?0
	fi;
stop_process:
}
proctype mainstartRemoteInputFowarding(Chandef doneChan;chan child) {
	bool closed; 
	int i;
	run Anonymous5(doneChan);
	child!0;
stop_process:
}
proctype Anonymous5(Chandef doneChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	od;
for20_exit:	
	if
	:: doneChan.async_send!0;
	:: doneChan.sync!0 -> 
		doneChan.sending?0
	fi;
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

