#define Refresh_bc_workers 3
#define Refresh_cache_Nodes 3
#define Refresh_partial 1
#define Refresh_centrality 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example581033907/autopilot/betweenness_centrality.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int centrality = Refresh_centrality;
	Chandef partials;
	Wgdef wg;
	int cache_Nodes = Refresh_cache_Nodes;
	bool state = false;
	Chandef work;
	int bc_workers = Refresh_bc_workers;
	int partial = Refresh_partial;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	run sync_monitor(work);
	
	if
	:: bc_workers > 0 -> 
		partials.size = bc_workers;
		run emptyChan(partials)
	:: else -> 
		run sync_monitor(partials)
	fi;
	wg.Add!bc_workers;
		for(i : 0.. bc_workers-1) {
for10:
	};
for10_exit:		for(i : 0.. cache_Nodes-1) {
for20:		
		if
		:: work.async_send!0;
		:: work.sync!0 -> 
			work.sending?0
		fi
	};
	work.closing!true;
	wg.Wait?0;
	partials.closing!true;
	do
	:: partials.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: partials.async_rcv?0;
			:: partials.sync?0;
			fi;
			
			if
			:: 0 != -1 && partial-1 != -1 -> 
								for(i : 0.. partial-1) {
for31:
				}
			:: else -> 
				do
				:: true -> 
for31:
				:: true -> 
					break
				od
			fi;
for31_exit:
		fi
	od;
	
	if
	:: true -> 
				for(i : 0.. centrality-1) {
for40:
		}
	:: true;
	fi;
		for(i : 0.. centrality-1) {
for50:
	};
	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
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


