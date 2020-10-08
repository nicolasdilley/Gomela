#define lb_for245_0  -1
#define ub_for245_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example369565110/app/command.go
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
	Wgdef wg;
	Chandef mentionChan;
	int possibleMentions = 5;
	bool state = false;
	
	if
	:: possibleMentions > 0 -> 
		mentionChan.size = possibleMentions;
		run emptyChan(mentionChan)
	:: else -> 
		run sync_monitor(mentionChan)
	fi;
	run wgMonitor(wg);
		for(i : 1.. possibleMentions) {
for10:		wg.Add!1;
		run Anonymous0(mentionChan,wg)
	};
	wg.Wait?0;
	mentionChan.closing!true;
	do
	:: mentionChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: mentionChan.async_rcv?0;
			:: mentionChan.sync?0;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef mentionChan;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: lb_for245_0 != -1 && ub_for245_1 != -1 -> 
						for(i : lb_for245_0.. ub_for245_1) {
for11:				
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
				:: mentionChan.async_send!0;
				:: mentionChan.sync!0 -> 
					mentionChan.sending?0
				fi;
				goto stop_process
			}
		:: else -> 
			do
			:: true -> 
for11:				
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
				:: mentionChan.async_send!0;
				:: mentionChan.sync!0 -> 
					mentionChan.sending?0
				fi;
				goto stop_process
			:: true -> 
				break
			od
		fi;
for11_exit:		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: mentionChan.async_send!0;
	:: mentionChan.sync!0 -> 
		mentionChan.sending?0
	fi;
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

