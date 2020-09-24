#define partitionInfos  5
#define partitionInfos  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example284558253/cmd/influx_inspect/verify/seriesfile/verify.go
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
	int partitionInfos = 5;
	Wgdef wg;
	Chandef in;
	int concurrent = 5;
	bool state = false;
	Chandef out;
	Chandef v_done;
	int in = 5;
	int i;
	
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
	:: partitionInfos > 0 -> 
		in.size = partitionInfos;
		run emptyChan(in)
	:: else -> 
		run sync_monitor(in)
	fi;
	
	if
	:: partitionInfos > 0 -> 
		out.size = partitionInfos;
		run emptyChan(out)
	:: else -> 
		run sync_monitor(out)
	fi;
	run wgMonitor(wg);
	run sync_monitor(v_done);
		for(i : 0.. concurrent-1) {
for10:		wg.Add!1;
		run Anonymous0(in,out,v_done,wg)
	};
for10_exit:	do
	:: true -> 
for20:		
		if
		:: in.async_send!0;
		:: in.sync!0 -> 
			in.sending?0
		fi
	:: true -> 
		break
	od;
	in.closing!true;
	do
	:: true -> 
for30:		
		if
		:: out.async_rcv?0;
		:: out.sync?0;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	:: true -> 
		break
	od;
	goto stop_process;
	wg.Wait?0;
	v_done.closing!true
stop_process:}

proctype Anonymous0(Chandef in;Chandef out;Chandef v_done;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: in.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			in.in?0;
			do
			:: out.async_send!0 -> 
				break
			:: out.sync!0 -> 
				out.sending?0;
				break
			:: true -> 
				goto stop_process
			od
		fi
	od;
	wg.Add!-1;
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

