#define lb_for2533_0  -1
#define ub_for2533_1  -1
#define lb_for2626_2  -1
#define ub_for2626_3  -1
#define lb_for2481_4  -1
#define ub_for2481_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example989685069/client.go
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
	Chandef doneW;
	bool state = false;
	Chandef doneR;
	Chandef stopW;
	Chandef stopR;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(stopW);
	run sync_monitor(doneW);
	run Anonymous0(stopW,doneW,stopR,doneR);
	run sync_monitor(stopR);
	run sync_monitor(doneR);
	run Anonymous2(stopW,doneW,stopR,doneR);
	do
	od;
	
	if
	:: lb_for2481_4 != -1 && ub_for2481_5 != -1 -> 
				for(i : lb_for2481_4.. ub_for2481_5) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype cwriter(Chandef stopCh;chan child) {
	bool closed; 
	int i;
	Chandef instantTimerCh;
	run sync_monitor(instantTimerCh);
	instantTimerCh.closing!true;
	do
	:: true -> 
for10:againChW:				do
		:: true -> 
			do
			:: true -> 
				goto stop_process
			:: stopCh.async_rcv?0 -> 
				goto stop_process
			:: stopCh.sync?0 -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto againChW
			od;
			break
		od;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
againChR:				do
		:: true;
		:: true -> 
			do
			:: true;
			:: stopCh.async_rcv?0 -> 
				goto stop_process
			:: stopCh.sync?0 -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto againChR
			od;
			break
		od
	od;
for10_exit:	child!0;
stop_process:
}
proctype Anonymous0(Chandef stopW;Chandef doneW;Chandef stopR;Chandef doneR) {
	bool closed; 
	int i;
	chan child_cwriter0 = [0] of {int};
	run cwriter(stopW,child_cwriter0);
	child_cwriter0?0;
	
	if
	:: doneW.async_send!0;
	:: doneW.sync!0 -> 
		doneW.sending?0
	fi;
stop_process:
}
proctype creader(Chandef stopCh;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true -> 
			do
			:: stopCh.async_rcv?0 -> 
				goto stop_process
			:: stopCh.sync?0 -> 
				goto stop_process
			od;
			break
		od;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for20_exit:	child!0;
stop_process:
}
proctype Anonymous2(Chandef stopW;Chandef doneW;Chandef stopR;Chandef doneR) {
	bool closed; 
	int i;
	chan child_creader1 = [0] of {int};
	run creader(stopR,child_creader1);
	child_creader1?0;
	
	if
	:: doneR.async_send!0;
	:: doneR.sync!0 -> 
		doneR.sending?0
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

