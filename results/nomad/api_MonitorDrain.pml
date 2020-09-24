#define lb_for161_0  -1
#define ub_for161_1  -1
#define lb_for215_2  -1
#define ub_for215_3  -1
#define lb_for269_4  -1
#define ub_for269_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example542209901/api/nodes.go
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
	Chandef nodeCh;
	Chandef outCh;
	Chandef allocCh;
	bool state = false;
	
	if
	:: 8 > 0 -> 
		outCh.size = 8;
		run emptyChan(outCh)
	:: else -> 
		run sync_monitor(outCh)
	fi;
	
	if
	:: 1 > 0 -> 
		nodeCh.size = 1;
		run emptyChan(nodeCh)
	:: else -> 
		run sync_monitor(nodeCh)
	fi;
	
	if
	:: 8 > 0 -> 
		allocCh.size = 8;
		run emptyChan(allocCh)
	:: else -> 
		run sync_monitor(allocCh)
	fi;
	run go_nmonitorDrainMultiplex(outCh,nodeCh,allocCh);
	run go_nmonitorDrainNode(nodeCh);
	run go_nmonitorDrainAllocs(allocCh);
	goto stop_process
stop_process:}

proctype go_nmonitorDrainMultiplex(Chandef outCh;Chandef nodeCh;Chandef allocCh) {
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
		do
		:: true -> 
			goto stop_process
		od;
		do
		:: outCh.async_send!0 -> 
			break
		:: outCh.sync!0 -> 
			outCh.sending?0;
			break
		:: true -> 
			goto stop_process
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for10_exit:	outCh.closing!true;
stop_process:
}
proctype go_nmonitorDrainNode(Chandef nodeCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			do
			:: nodeCh.async_send!0 -> 
				break
			:: nodeCh.sync!0 -> 
				nodeCh.sending?0;
				break
			:: true;
			od;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: nodeCh.async_send!0 -> 
				break
			:: nodeCh.sync!0 -> 
				nodeCh.sending?0;
				break
			:: true;
			od;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: nodeCh.async_send!0 -> 
				break
			:: nodeCh.sync!0 -> 
				nodeCh.sending?0;
				break
			:: true;
			od
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: nodeCh.async_send!0 -> 
				break
			:: nodeCh.sync!0 -> 
				nodeCh.sending?0;
				break
			:: true -> 
				goto stop_process
			od
		:: true;
		fi
	od;
for20_exit:	nodeCh.closing!true;
stop_process:
}
proctype go_nmonitorDrainAllocs(Chandef allocCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			do
			:: allocCh.async_send!0 -> 
				break
			:: allocCh.sync!0 -> 
				allocCh.sending?0;
				break
			:: true;
			od;
			goto stop_process
		:: true;
		fi;
		do
		:: true -> 
for31:			

			if
			:: true;
			:: true;
			:: true;
			:: true;
			fi;
			
			if
			:: true -> 
				do
				:: allocCh.async_send!0 -> 
					break
				:: allocCh.sync!0 -> 
					allocCh.sending?0;
					break
				:: true -> 
					goto stop_process
				od
			:: true;
			fi;
			

			if
			:: true;
			fi
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			do
			:: allocCh.async_send!0 -> 
				break
			:: allocCh.sync!0 -> 
				allocCh.sending?0;
				break
			:: true;
			od;
			goto stop_process
		:: true;
		fi
	od;
for30_exit:	allocCh.closing!true;
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

