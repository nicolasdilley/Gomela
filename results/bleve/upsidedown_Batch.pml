#define batch_IndexOps  5
#define batch_IndexOps  5
#define batch_IndexOps  5
#define lb_for871_3  -1
#define ub_for871_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example774409785/index/upsidedown/upsidedown.go
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
	Chandef docBackIndexRowCh;
	int i;
	int batch_InternalOps = 5;
	Chandef resultChan;
	int batch_IndexOps = 5;
	int docBackIndexRowCh = 5;
	bool state = false;
	
	if
	:: batch_IndexOps > 0 -> 
		resultChan.size = batch_IndexOps;
		run emptyChan(resultChan)
	:: else -> 
		run sync_monitor(resultChan)
	fi;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		run Anonymous0(resultChan,docBackIndexRowCh)
	:: true;
	fi;
	
	if
	:: batch_IndexOps > 0 -> 
		docBackIndexRowCh.size = batch_IndexOps;
		run emptyChan(docBackIndexRowCh)
	:: else -> 
		run sync_monitor(docBackIndexRowCh)
	fi;
	run Anonymous1(resultChan,docBackIndexRowCh);
	
	if
	:: lb_for871_3 != -1 && ub_for871_4 != -1 -> 
				for(i : lb_for871_3.. ub_for871_4) {
for40:			
			if
			:: resultChan.async_rcv?0;
			:: resultChan.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: resultChan.async_rcv?0;
			:: resultChan.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for40_exit:	resultChan.closing!true;
	do
	:: true -> 
for50:
	:: true -> 
		break
	od;
	do
	:: docBackIndexRowCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			docBackIndexRowCh.in?0
		fi
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef resultChan;Chandef docBackIndexRowCh) {
	bool closed; 
	int i;
		for(i : 1.. batch_IndexOps) {
for20:
	};
stop_process:
}
proctype Anonymous1(Chandef resultChan;Chandef docBackIndexRowCh) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: docBackIndexRowCh.async_send!0;
		:: docBackIndexRowCh.sync!0 -> 
			docBackIndexRowCh.sending?0
		fi
	:: true -> 
		break
	od;
	docBackIndexRowCh.closing!true;
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

