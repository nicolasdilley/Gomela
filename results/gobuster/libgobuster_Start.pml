#define g_Opts_Threads  5
#define lb_for89_1  -1
#define ub_for89_2  -1
#define lb_for180_3  -1
#define ub_for180_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example657976585/libgobuster/libgobuster.go
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
	int g_Opts_Threads = 5;
	Wgdef workerGroup;
	bool state = false;
	Chandef wordChan;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(workerGroup);
	workerGroup.Add!g_Opts_Threads;
	
	if
	:: g_Opts_Threads > 0 -> 
		wordChan.size = g_Opts_Threads;
		run emptyChan(wordChan)
	:: else -> 
		run sync_monitor(wordChan)
	fi;
		for(i : 0.. g_Opts_Threads-1) {
for10:		run go_gworker(wordChan,workerGroup)
	};
for10_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
Scan:		
	if
	:: lb_for180_3 != -1 && ub_for180_4 != -1 -> 
				for(i : lb_for180_3.. ub_for180_4) {
for20:			do
			:: true -> 
				goto Scan
			:: wordChan.async_send!0 -> 
				break
			:: wordChan.sync!0 -> 
				wordChan.sending?0;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
				goto Scan
			:: wordChan.async_send!0 -> 
				break
			:: wordChan.sync!0 -> 
				wordChan.sending?0;
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:;
	wordChan.closing!true;
	workerGroup.Wait?0;
	goto stop_process
stop_process:}

proctype go_gworker(Chandef wordChan;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		do
		:: true -> 
			goto stop_process
		od
	od;
for11_exit:	wg.Add!-1;
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

