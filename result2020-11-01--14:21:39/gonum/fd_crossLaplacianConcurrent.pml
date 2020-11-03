#define crossLaplacianConcurrent_evals 0
#define crossLaplacianConcurrent_nWorkers 1
#define crossLaplacianConcurrent_n 3
#define crossLaplacianConcurrent_stencil 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example113587139/diff/fd/crosslaplacian.go
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
	int n = crossLaplacianConcurrent_n;
	Wgdef originWG;
	Chandef send;
	int evals = crossLaplacianConcurrent_evals;
	int i;
	Chandef ans;
	Wgdef workerWG;
	int nWorkers = crossLaplacianConcurrent_nWorkers;
	int stencil = crossLaplacianConcurrent_stencil;
	bool state = false;
	
	if
	:: evals > 0 -> 
		send.size = evals;
		run emptyChan(send)
	:: else -> 
		run sync_monitor(send)
	fi;
	
	if
	:: evals > 0 -> 
		ans.size = evals;
		run emptyChan(ans)
	:: else -> 
		run sync_monitor(ans)
	fi;
	run wgMonitor(originWG);
	
	if
	:: true -> 
		originWG.Add!1;
		run Anonymous0(send,ans,originWG,workerWG)
	:: true;
	fi;
	run wgMonitor(workerWG);
		for(i : 0.. nWorkers-1) {
for10:		workerWG.Add!1;
		run Anonymous1(send,ans,originWG,workerWG)
	};
for10_exit:	run Anonymous2(send,ans,originWG,workerWG);
	do
	:: ans.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: ans.async_rcv?0;
			:: ans.sync?0;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef send;Chandef ans;Wgdef originWG;Wgdef workerWG) {
	bool closed; 
	int i;
	bool state;
stop_process:	originWG.Add!-1
}
proctype Anonymous1(Chandef send;Chandef ans;Wgdef originWG;Wgdef workerWG) {
	bool closed; 
	int i;
	bool state;
	do
	:: send.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: send.async_rcv?0;
			:: send.sync?0;
			fi;
			
			if
			:: true -> 
				originWG.Wait?0
			fi;
			
			if
			:: ans.async_send!0;
			:: ans.sync!0 -> 
				ans.sending?0
			fi
		fi
	od;
stop_process:	workerWG.Add!-1
}
proctype Anonymous2(Chandef send;Chandef ans;Wgdef originWG;Wgdef workerWG) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && n-1 != -1 -> 
				for(i : 0.. n-1) {
for20:						for(i : 0.. stencil-1) {
for21:								for(i : 0.. stencil-1) {
for22:					
					if
					:: send.async_send!0;
					:: send.sync!0 -> 
						send.sending?0
					fi
				}
			}
		}
	:: else -> 
		do
		:: true -> 
for20:						for(i : 0.. stencil-1) {
for21:								for(i : 0.. stencil-1) {
for22:					
					if
					:: send.async_send!0;
					:: send.sync!0 -> 
						send.sending?0
					fi
				}
			}
		:: true -> 
			break
		od
	fi;
for20_exit:	send.closing!true;
	workerWG.Wait?0;
	ans.closing!true;
stop_process:
}
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


