
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example078130859/pushbackend.go
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
	Chandef ret_errChan;
	int i;
	chan child_psmSetErrorReportChan2 = [0] of {int};
	bool state = false;
	run sync_monitor(ret_errChan);
	run psmSetErrorReportChan(ret_errChan,child_psmSetErrorReportChan0);
	child_psmSetErrorReportChan2?0;
	goto stop_process
stop_process:}

proctype psmSetErrorReportChan(Chandef errChan;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		chan child_t_pstSetErrorReportChan1 = [0] of {int};
		run t_pstSetErrorReportChan(errChan,child_t_pstSetErrorReportChan0);
		child_t_pstSetErrorReportChan1?0
	:: true -> 
		break
	od;
stop_process:	child!0
}
proctype t_pstSetErrorReportChan(Chandef errChan;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for11:		chan child_t_pstSetErrorReportChan0 = [0] of {int};
		run t_pstSetErrorReportChan(errChan,child_t_pstSetErrorReportChan0);
		child_t_pstSetErrorReportChan0?0
	:: true -> 
		break
	od;
stop_process:	child!0
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

