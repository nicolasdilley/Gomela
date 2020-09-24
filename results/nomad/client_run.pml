#define 8  5
#define lb_for1987_1  -1
#define ub_for1987_2  -1
#define lb_for1650_3  -1
#define ub_for1650_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example542209901/client/client.go
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
	Chandef allocUpdates;
	bool state = false;
	
	if
	:: 8 > 0 -> 
		allocUpdates.size = 8;
		run emptyChan(allocUpdates)
	:: else -> 
		run sync_monitor(allocUpdates)
	fi;
	run go_cwatchAllocations(allocUpdates);
	do
	:: true -> 
for20:		do
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

proctype go_cwatchAllocations(Chandef updates) {
	bool closed; 
	int i;
OUTER:		do
	:: true -> 
for10:		
		if
		:: true -> 
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od;
			do
			:: true;
			:: true;
			:: true -> 
				goto stop_process
			od
		:: true;
		fi;
		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		od;
		do
		:: true -> 
for11:
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			
			if
			:: true -> 
				do
				:: true;
				:: true;
				:: true -> 
					goto stop_process
				od
			:: true;
			fi;
			do
			:: true -> 
for12:
			:: true -> 
				break
			od;
			do
			:: true -> 
for13:				
				if
				:: true -> 
					do
					:: true;
					:: true -> 
						goto stop_process
					od
				:: true;
				fi
			:: true -> 
				break
			od;
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od
		:: true;
		fi;
		do
		:: updates.async_send!0 -> 
			break
		:: updates.sync!0 -> 
			updates.sending?0;
			break
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:;
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

