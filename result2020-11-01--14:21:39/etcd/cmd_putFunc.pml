#define putFunc_totalClients 1
#define putFunc_clients 1
#define putFunc_putTotal 3
#define lb_for122_3  -1
#define ub_for122_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example997875907/tools/benchmark/cmd/put.go
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
	int clients = putFunc_clients;
	Chandef requests;
	int i;
	int totalClients = putFunc_totalClients;
	int putTotal = putFunc_putTotal;
	bool state = false;
	
	if
	:: totalClients > 0 -> 
		requests.size = totalClients;
		run emptyChan(requests)
	:: else -> 
		run sync_monitor(requests)
	fi;
		for(i : 0.. clients-1) {
for10:		run Anonymous0(requests)
	};
	run Anonymous1(requests);
	
	if
	:: true -> 
		run Anonymous2(requests)
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef requests) {
	bool closed; 
	int i;
	bool state;
	do
	:: requests.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: requests.async_rcv?0;
			:: requests.sync?0;
			fi
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef requests) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && putTotal-1 != -1 -> 
				for(i : 0.. putTotal-1) {
for20:			
			if
			:: requests.async_send!0;
			:: requests.sync!0 -> 
				requests.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: requests.async_send!0;
			:: requests.sync!0 -> 
				requests.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	requests.closing!true;
stop_process:
}
proctype Anonymous2(Chandef requests) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for30:
	od;
for30_exit:stop_process:
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


