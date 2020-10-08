#define lb_for180_0  -1
#define ub_for180_1  -1
#define lb_for207_2  -1
#define ub_for207_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example237974147/rpc/rand_lb.go
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
	Chandef r_exitCH;
	Chandef retryCH;
	int r_Clients = 5;
	bool state = false;
	
	if
	:: 10 > 0 -> 
		retryCH.size = 10;
		run emptyChan(retryCH)
	:: else -> 
		run sync_monitor(retryCH)
	fi;
	
	if
	:: 1 > 0 -> 
		r_exitCH.size = 1;
		run emptyChan(r_exitCH)
	:: else -> 
		run sync_monitor(r_exitCH)
	fi;
		for(i : 1.. r_Clients) {
for10:		run Anonymous0(retryCH,r_exitCH)
	};
	run Anonymous1(retryCH,r_exitCH)
stop_process:}

proctype Anonymous0(Chandef retryCH;Chandef r_exitCH) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			
			if
			:: retryCH.async_send!0;
			:: retryCH.sync!0 -> 
				retryCH.sending?0
			fi
		:: true;
		fi
	od;
for11_exit:stop_process:
}
proctype Anonymous1(Chandef retryCH;Chandef r_exitCH) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true -> 
			goto stop_process
		od;
				for(i : 1.. r_Clients) {
for21:
		}
	od;
for20_exit:stop_process:
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

