
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example630181178/pkg/blobserver/blobhub.go
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
	int i;
	Chandef ch;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		ch.size = 1;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	
	if
	:: true -> 
		chan child_hubRegisterListener0 = [0] of {int};
		run hubRegisterListener(ch,child_hubRegisterListener0);
		child_hubRegisterListener0?0;
		chan child_hubUnregisterListener1 = [0] of {int};
		run hubUnregisterListener(ch,child_hubUnregisterListener1);
		child_hubUnregisterListener1?0
	:: true;
	fi;
		for(i : 1.. blobs) {
for10:		chan child_hubRegisterBlobListener2 = [0] of {int};
		run hubRegisterBlobListener(ch,child_hubRegisterBlobListener2);
		child_hubRegisterBlobListener2?0;
		chan child_hubUnregisterBlobListener3 = [0] of {int};
		run hubUnregisterBlobListener(ch,child_hubUnregisterBlobListener3);
		child_hubUnregisterBlobListener3?0
	};
	do
	:: ch.async_rcv?0 -> 
		break
	:: ch.sync?0 -> 
		break
	:: true;
	:: true;
	od
stop_process:}

proctype hubRegisterListener(Chandef ch;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
proctype hubUnregisterListener(Chandef ch;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
proctype hubRegisterBlobListener(Chandef ch;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
proctype hubUnregisterBlobListener(Chandef ch;chan child) {
	bool closed; 
	int i;
	child!0;
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

