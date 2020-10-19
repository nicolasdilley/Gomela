#define AnalyzeRepositories_sess_Repositories  60
#define AnalyzeRepositories_threadNum  60
#define AnalyzeRepositories_history  60
#define AnalyzeRepositories_changes  60
#define AnalyzeRepositories_core_Signatures  60
#define lb_for108_5  -1
#define ub_for108_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example241296606/main.go
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
	int i;
	int threadNum = AnalyzeRepositories_threadNum;
	Wgdef wg;
	int changes = AnalyzeRepositories_changes;
	Chandef ch;
	int sess_Repositories = AnalyzeRepositories_sess_Repositories;
	int history = AnalyzeRepositories_history;
	int core_Signatures = AnalyzeRepositories_core_Signatures;
	bool state = false;
	
	if
	:: sess_Repositories > 0 -> 
		ch.size = sess_Repositories;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run wgMonitor(wg);
	wg.Add!threadNum;
		for(i : 0.. threadNum-1) {
for10:		run Anonymous0(ch,wg)
	};
for10_exit:		for(i : 1.. sess_Repositories) {
for20:		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi
	};
	ch.closing!true;
	wg.Wait?0
stop_process:}

proctype Anonymous0(Chandef ch;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for11:		
		if
		:: ch.async_rcv?0;
		:: ch.sync?0;
		fi;
		
		if
		:: true -> 
			wg.Add!-1;
			goto stop_process
		:: true;
		fi;
				for(i : 1.. history) {
for12:						for(i : 1.. changes) {
for13:								for(i : 1.. core_Signatures) {
for14:					
					if
					:: true -> 
						break
					:: true;
					fi
				}
			}
		}
	od;
for11_exit:stop_process:
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

