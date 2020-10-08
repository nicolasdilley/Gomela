#define lb_for330_0  -1
#define ub_for330_1  -1
#define lb_for363_2  -1
#define ub_for363_3  -1
#define lb_for222_4  -1
#define ub_for222_5  -1
#define lb_for463_6  -1
#define ub_for463_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example672862733/pkg/workload/cli/run.go
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
	Wgdef wg;
	bool state = false;
	int ops_WorkerFns = 5;
	Chandef errCh;
	Chandef done;
	int i;
	

	if
	:: true;
	:: true;
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od;
for10_exit:
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for363_2 != -1 && ub_for363_3 != -1 -> 
				for(i : lb_for363_2.. ub_for363_3) {
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(errCh);
	
	if
	:: true -> 
		Chandef rampDone;
		run sync_monitor(rampDone)
	:: true;
	fi;
	run wgMonitor(wg);
	wg.Add!ops_WorkerFns;
	run Anonymous0(errCh,rampDone,done,wg);
	
	if
	:: 3 > 0 -> 
		done.size = 3;
		run emptyChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run Anonymous3(errCh,rampDone,done,wg);
	
	if
	:: true -> 
		run Anonymous4(errCh,rampDone,done,wg)
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	do
	:: true -> 
for40:		do
		:: true;
		:: rampDone.async_rcv?0 -> 
			break
		:: rampDone.sync?0 -> 
			break
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		od
	od;
for40_exit:
stop_process:}

proctype cliworkerRun(Chandef errCh;Wgdef wg;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		wg.Add!-1
	:: true;
	fi;
	do
	:: true -> 
for31:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
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
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for31_exit:	child!0;
stop_process:
}
proctype Anonymous0(Chandef errCh;Chandef rampDone;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	chan child_cliworkerRun0 = [0] of {int};
	run cliworkerRun(errCh,wg,child_cliworkerRun0);
	child_cliworkerRun0?0;
stop_process:
}
proctype Anonymous0(Chandef errCh;Chandef rampDone;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
		for(i : 1.. ops_WorkerFns) {
for30:		run Anonymous0(errCh,rampDone,done,wg)
	};
	
	if
	:: true -> 
		rampDone.closing!true
	:: true;
	fi;
stop_process:
}
proctype Anonymous3(Chandef errCh;Chandef rampDone;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	wg.Wait?0;
	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi;
stop_process:
}
proctype Anonymous4(Chandef errCh;Chandef rampDone;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: done.async_send!0;
	:: done.sync!0 -> 
		done.sending?0
	fi;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
	od;
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

