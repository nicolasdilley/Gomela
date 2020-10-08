#define lb_for773_0  -1
#define ub_for773_1  -1
#define lb_for993_2  -1
#define ub_for993_3  -1
#define lb_for1102_4  -1
#define ub_for1102_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example326115153/etcd/etcd.go
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
	int obj_clients = 5;
	Wgdef wg;
	bool state = false;
	Chandef chooserChan;
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
	run wgMonitor(wg);
	wg.Add!1;
	run Anonymous0(chooserChan,unvolunteered);
	run Anonymous1(chooserChan,unvolunteered);
	run Anonymous7(chooserChan,unvolunteered);
	run Anonymous8(chooserChan,unvolunteered);
	run sync_monitor(chooserChan);
	run Anonymous9(chooserChan,unvolunteered);
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: true;
		:: true -> 
			goto stop_process
		od;
		
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
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			do
			:: true;
			:: true -> 
				goto stop_process
			od
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run Anonymous10(chooserChan,unvolunteered);
		do
		:: true;
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		od;
		do
		:: true;
		od
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Chandef unvolunteered;
		run sync_monitor(unvolunteered);
		run Anonymous11(chooserChan,unvolunteered);
		
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
		do
		:: unvolunteered.async_rcv?0 -> 
			break
		:: unvolunteered.sync?0 -> 
			break
		:: true;
		od;
		
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
	run Anonymous12(chooserChan,unvolunteered);
	do
	:: true;
	od;
	goto stop_process;
	wg.Wait?0;
	
	if
	:: 0 != -1 && obj_clients - 1 != -1 -> 
				for(i : 0.. obj_clients - 1) {
for20:
		}
	:: else -> 
		do
		:: true -> 
for20:
		:: true -> 
			break
		od
	fi;
for20_exit:	
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
stop_process:}

proctype Anonymous0(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	do
	:: true;
	:: true;
	od;
	do
	:: true;
	:: true;
	od;
stop_process:
}
proctype Anonymous1(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	do
	:: true;
	:: true;
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true;
	od;
stop_process:
}
proctype Anonymous2(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	do
	:: true;
	:: true;
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true;
	od;
stop_process:
}
proctype Anonymous3(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	do
	:: true;
	:: true;
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true;
	od;
stop_process:
}
proctype Anonymous4(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	do
	:: true;
	:: true;
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true;
	od;
stop_process:
}
proctype Anonymous5(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	do
	:: true;
	:: true;
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true;
	od;
stop_process:
}
proctype Anonymous1(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	Wgdef wg;
	run wgMonitor(wg);
	wg.Add!1;
	run Anonymous1(chooserChan,unvolunteered);
	wg.Add!1;
	run Anonymous2(chooserChan,unvolunteered);
	wg.Add!1;
	run Anonymous3(chooserChan,unvolunteered);
	wg.Add!1;
	run Anonymous4(chooserChan,unvolunteered);
	wg.Add!1;
	run Anonymous5(chooserChan,unvolunteered);
	wg.Wait?0;
	do
	:: true;
	od;
stop_process:
}
proctype Anonymous7(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
Loop:		do
	:: true -> 
for10:		do
		od
	od;
for10_exit:;
stop_process:
}
proctype Anonymous8(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: true;
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	:: true;
	fi;
	
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
stop_process:
}
proctype Anonymous9(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true;
	:: true -> 
		goto stop_process
	od;
	
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
proctype Anonymous10(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for30_exit:stop_process:
}
proctype Anonymous11(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	do
	:: true -> 
for40:		do
		od;
		
		if
		:: true -> 
			
			if
			:: true -> 
				unvolunteered.closing!true
			:: true;
			fi
		:: true;
		fi
	od;
for40_exit:stop_process:
}
proctype Anonymous12(Chandef chooserChan;Chandef unvolunteered) {
	bool closed; 
	int i;
	do
	:: true;
	:: true;
	od;
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

