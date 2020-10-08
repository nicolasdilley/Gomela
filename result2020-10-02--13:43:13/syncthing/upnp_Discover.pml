#define lb_for189_0  -1
#define ub_for189_1  -1
#define lb_for123_2  -1
#define ub_for123_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example590169631/lib/upnp/upnp.go
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
	int interfaces = 5;
	Chandef resultChan;
	bool state = false;
	Wgdef wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(resultChan);
	run wgMonitor(wg);
		for(i : 1.. interfaces) {
for10:				for(i : 1.. 2) {
for11:			wg.Add!1;
			run Anonymous0(resultChan)
		}
	};
	run Anonymous2(resultChan);
	do
	:: true -> 
for20:		do
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:
stop_process:}

proctype upnpdiscover(Chandef results;chan child) {
	bool closed; 
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
loop:		do
	:: true -> 
for12:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: true -> 
				goto loop
			:: true -> 
				break
			od;
			break
		:: true;
		fi;
		do
		:: true -> 
for13:			do
			:: results.async_send!0 -> 
				break
			:: results.sync!0 -> 
				results.sending?0;
				break
			:: true -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	od;
for12_exit:;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef resultChan) {
	bool closed; 
	int i;
	chan child_upnpdiscover0 = [0] of {int};
	run upnpdiscover(resultChan,child_upnpdiscover0);
	child_upnpdiscover0?0;
stop_process:
}
proctype Anonymous2(Chandef resultChan) {
	bool closed; 
	int i;
	resultChan.closing!true;
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

