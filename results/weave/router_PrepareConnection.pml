#define ChannelSize  5
#define ChannelSize  5
#define lb_for639_2  -1
#define ub_for639_3  -1
#define lb_for703_4  -1
#define ub_for703_5  -1
#define lb_for710_6  -1
#define ub_for710_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example106461167/router/sleeve.go
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
	Chandef fwd_establishedChan;
	Chandef specialChan;
	Chandef aggChan;
	Chandef confirmedChan;
	int i;
	Chandef aggDFChan;
	Chandef controlMsgChan;
	Chandef finishedChan;
	Chandef fwd_errorChan;
	bool state = false;
	
	if
	:: ChannelSize > 0 -> 
		aggChan.size = ChannelSize;
		run emptyChan(aggChan)
	:: else -> 
		run sync_monitor(aggChan)
	fi;
	
	if
	:: ChannelSize > 0 -> 
		aggDFChan.size = ChannelSize;
		run emptyChan(aggDFChan)
	:: else -> 
		run sync_monitor(aggDFChan)
	fi;
	
	if
	:: 1 > 0 -> 
		specialChan.size = 1;
		run emptyChan(specialChan)
	:: else -> 
		run sync_monitor(specialChan)
	fi;
	
	if
	:: 1 > 0 -> 
		controlMsgChan.size = 1;
		run emptyChan(controlMsgChan)
	:: else -> 
		run sync_monitor(controlMsgChan)
	fi;
	run sync_monitor(confirmedChan);
	run sync_monitor(finishedChan);
	run sync_monitor(fwd_establishedChan);
	
	if
	:: 1 > 0 -> 
		fwd_errorChan.size = 1;
		run emptyChan(fwd_errorChan)
	:: else -> 
		run sync_monitor(fwd_errorChan)
	fi;
	run go_fwdrun(aggChan,aggDFChan,specialChan,controlMsgChan,confirmedChan,finishedChan);
	goto stop_process
stop_process:}

proctype go_fwdrun(Chandef aggChan;Chandef aggDFChan;Chandef specialChan;Chandef controlMsgChan;Chandef confirmedChan;Chandef finishedChan) {
	bool closed; 
	int i;
loop:		
	if
	:: lb_for639_2 != -1 && ub_for639_3 != -1 -> 
				for(i : lb_for639_2.. ub_for639_3) {
for10:			do
			:: true;
			:: true;
			:: true;
			:: true;
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true;
			:: true;
			:: true;
			:: true;
			od
		:: true -> 
			break
		od
	fi;
for10_exit:;
	finishedChan.closing!true;
stop_process:
}
proctype fwdaggregateAndSend(Chandef aggChan;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
for12:			
			if
			:: true -> 
				do
				:: true -> 
					break
				od
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		od;
for12_exit:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for11_exit:	child!0;
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

