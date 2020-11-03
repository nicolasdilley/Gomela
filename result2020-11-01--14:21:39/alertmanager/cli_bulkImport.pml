#define bulkImport_c_workers 3
#define lb_for120_1  -1
#define ub_for120_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example181347803/cli/silence_import.go
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
	Chandef errc;
	bool state = false;
	int c_workers = bulkImport_c_workers;
	Chandef silencec;
	Wgdef wg;
	int i;
	
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
	
	if
	:: 100 > 0 -> 
		silencec.size = 100;
		run emptyChan(silencec)
	:: else -> 
		run sync_monitor(silencec)
	fi;
	
	if
	:: 100 > 0 -> 
		errc.size = 100;
		run emptyChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	run wgMonitor(wg);
		for(i : 0.. c_workers-1) {
for10:		wg.Add!1;
		run Anonymous0(silencec,errc,wg)
	};
for10_exit:	run Anonymous2(silencec,errc,wg);
	
	if
	:: lb_for120_1 != -1 && ub_for120_2 != -1 -> 
				for(i : lb_for120_1.. ub_for120_2) {
for30:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: silencec.async_send!0;
			:: silencec.sync!0 -> 
				silencec.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: silencec.async_send!0;
			:: silencec.sync!0 -> 
				silencec.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	silencec.closing!true;
	wg.Wait?0;
	errc.closing!true;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype cliaddSilenceWorker(Chandef silencec;Chandef errc;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: silencec.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: silencec.async_rcv?0;
			:: silencec.sync?0;
			fi;
			
			if
			:: errc.async_send!0;
			:: errc.sync!0 -> 
				errc.sending?0
			fi
		fi
	od;
stop_process:	child!0
}
proctype Anonymous0(Chandef silencec;Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_cliaddSilenceWorker0 = [0] of {int};
	run cliaddSilenceWorker(silencec,errc,child_cliaddSilenceWorker0);
	child_cliaddSilenceWorker0?0;
	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Chandef silencec;Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: errc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errc.async_rcv?0;
			:: errc.sync?0;
			fi
		fi
	od;
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


