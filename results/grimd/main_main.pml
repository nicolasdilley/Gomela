#define lb_for38_0  -1
#define ub_for38_1  -1
#define lb_for113_2  -1
#define ub_for113_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example452104691/main.go
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
	Chandef actChannel;
	int i;
	chan child_mainreloadBlockCache1 = [0] of {int};
	Chandef quitActivation;
	Chandef reloadChan;
	Chandef sig;
	bool state = false;
	run sync_monitor(quitActivation);
	run sync_monitor(actChannel);
	run go_mainstartActivation(actChannel,quitActivation);
	
	if
	:: actChannel.async_rcv?0;
	:: actChannel.sync?0;
	fi;
	actChannel.closing!true;
	run sync_monitor(reloadChan);
	run mainreloadBlockCache(reloadChan,child_mainreloadBlockCache0);
	child_mainreloadBlockCache1?0;
	run sync_monitor(sig);
forever:		do
	:: true -> 
for20:		do
		:: reloadChan.async_rcv?0 -> 
			chan child_mainreloadBlockCache2 = [0] of {int};
			run mainreloadBlockCache(reloadChan,child_mainreloadBlockCache2);
			child_mainreloadBlockCache2?0;
			break
		:: reloadChan.sync?0 -> 
			chan child_mainreloadBlockCache2 = [0] of {int};
			run mainreloadBlockCache(reloadChan,child_mainreloadBlockCache2);
			child_mainreloadBlockCache2?0;
			break
		od
	od;
for20_exit:;
	
	if
	:: quitActivation.async_rcv?0;
	:: quitActivation.sync?0;
	fi
stop_process:}

proctype go_mainstartActivation(Chandef actChannel;Chandef quit) {
	bool closed; 
	int i;
	Chandef a_toggleChannel;
	Chandef a_queryChannel;
	Chandef a_setChannel;
	run sync_monitor(a_queryChannel);
	run sync_monitor(a_toggleChannel);
	run sync_monitor(a_setChannel);
	
	if
	:: actChannel.async_send!0;
	:: actChannel.sync!0 -> 
		actChannel.sending?0
	fi;
forever:		do
	:: true -> 
for10:		do
		:: quit.async_rcv?0 -> 
			goto forever;
			break
		:: quit.sync?0 -> 
			goto forever;
			break
		:: a_queryChannel.async_rcv?0 -> 
			
			if
			:: a_queryChannel.async_send!0;
			:: a_queryChannel.sync!0 -> 
				a_queryChannel.sending?0
			fi;
			break
		:: a_queryChannel.sync?0 -> 
			
			if
			:: a_queryChannel.async_send!0;
			:: a_queryChannel.sync!0 -> 
				a_queryChannel.sending?0
			fi;
			break
		:: true;
		od
	od;
for10_exit:;
	
	if
	:: quit.async_send!0;
	:: quit.sync!0 -> 
		quit.sending?0
	fi;
stop_process:
}
proctype mainreloadBlockCache(Chandef reloadChan;chan child) {
	bool closed; 
	int i;
	chan child_mainStartAPIServer0 = [0] of {int};
	run mainStartAPIServer(reloadChan,child_mainStartAPIServer0);
	child_mainStartAPIServer0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype mainStartAPIServer(Chandef reloadChan;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous3(reloadChan);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous3(Chandef reloadChan) {
	bool closed; 
	int i;
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

