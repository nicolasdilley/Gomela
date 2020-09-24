#define 1  5
#define lb_for279_1  -1
#define ub_for279_2  -1
#define lb_for305_3  -1
#define ub_for305_4  -1
#define lb_for330_5  -1
#define ub_for330_6  -1
#define lb_for358_7  -1
#define ub_for358_8  -1
#define lb_for386_9  -1
#define ub_for386_10  -1
#define lb_for412_11  -1
#define ub_for412_12  -1
#define lb_for434_13  -1
#define ub_for434_14  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example696191423/uchiwa/daemon/daemon.go
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
	int i;
	Chandef errCh;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: 1 > 0 -> 
		errCh.size = 1;
		run emptyChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	wg.Add!7;
	run go_dfetchStashes(errCh);
	run go_dfetchSilenced(errCh);
	run go_dfetchChecks(errCh);
	run go_dfetchClients(errCh);
	run go_dfetchEvents(errCh);
	run go_dfetchInfo(errCh);
	run go_dfetchAggregates(errCh);
	
	if
	:: true -> 
		wg.Add!1;
		run go_dfetchEnterpriseMetrics(errCh)
	:: true;
	fi;
	run Anonymous8(errCh);
	do
	:: true;
	od
stop_process:}

proctype go_dfetchStashes(Chandef errCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
			do
			:: true -> 
for11:
			:: true -> 
				break
			od;
			goto stop_process
		od
	od;
for10_exit:stop_process:
}
proctype go_dfetchSilenced(Chandef errCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
			do
			:: true -> 
for21:
			:: true -> 
				break
			od;
			goto stop_process
		od
	od;
for20_exit:stop_process:
}
proctype go_dfetchChecks(Chandef errCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
			do
			:: true -> 
for31:
			:: true -> 
				break
			od;
			goto stop_process
		od
	od;
for30_exit:stop_process:
}
proctype go_dfetchClients(Chandef errCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for40:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
			do
			:: true -> 
for41:
			:: true -> 
				break
			od;
			goto stop_process
		od
	od;
for40_exit:stop_process:
}
proctype go_dfetchEvents(Chandef errCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for50:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
			do
			:: true -> 
for51:
			:: true -> 
				break
			od;
			goto stop_process
		od
	od;
for50_exit:stop_process:
}
proctype go_dfetchInfo(Chandef errCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for60:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
			goto stop_process
		od
	od;
for60_exit:stop_process:
}
proctype go_dfetchAggregates(Chandef errCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for70:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
			do
			:: true -> 
for71:
			:: true -> 
				break
			od;
			goto stop_process
		od
	od;
for70_exit:stop_process:
}
proctype go_dfetchEnterpriseMetrics(Chandef errCh) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous8(Chandef errCh) {
	bool closed; 
	int i;
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

