#define lb_for4425_0  -1
#define ub_for4425_1  -1
#define lb_for4489_2  -1
#define ub_for4489_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example473489835/rpcserver.go
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
	Chandef payChan;
	Chandef reqQuit;
	Chandef htlcSema;
	int i;
	Chandef errChan;
	Wgdef wg;
	int numOutstandingPayments = 5;
	bool state = false;
	run sync_monitor(payChan);
	
	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run emptyChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 2000 > 0 -> 
		htlcSema.size = 2000;
		run emptyChan(htlcSema)
	:: else -> 
		run sync_monitor(htlcSema)
	fi;
	
	if
	:: 0 != -1 && numOutstandingPayments-1 != -1 -> 
				for(i : 0.. numOutstandingPayments-1) {
for10:			
			if
			:: htlcSema.async_send!0;
			:: htlcSema.sync!0 -> 
				htlcSema.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: htlcSema.async_send!0;
			:: htlcSema.sync!0 -> 
				htlcSema.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	run wgMonitor(wg);
	run sync_monitor(reqQuit);
	wg.Add!1;
	run Anonymous0(payChan,errChan,htlcSema,reqQuit,wg);
sendLoop:			for(i : lb_for4489_2.. ub_for4489_3) {
for30:		do
		:: true -> 
			goto stop_process
		od
	};
for30_exit:;
	wg.Wait?0;
	goto stop_process;
	reqQuit.closing!true
stop_process:}

proctype Anonymous0(Chandef payChan;Chandef errChan;Chandef htlcSema;Chandef reqQuit;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: reqQuit.async_rcv?0 -> 
			goto stop_process
		:: reqQuit.sync?0 -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				payChan.closing!true;
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					do
					:: errChan.async_send!0 -> 
						break
					:: errChan.sync!0 -> 
						errChan.sending?0;
						break
					:: true -> 
						break
					od;
					goto stop_process
				:: true;
				fi
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					do
					:: errChan.async_send!0 -> 
						break
					:: errChan.sync!0 -> 
						errChan.sending?0;
						break
					:: true -> 
						break
					od;
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			do
			:: payChan.async_send!0 -> 
				break
			:: payChan.sync!0 -> 
				payChan.sending?0;
				break
			:: reqQuit.async_rcv?0 -> 
				goto stop_process
			:: reqQuit.sync?0 -> 
				goto stop_process
			od;
			break
		od
	od;
for20_exit:	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Chandef payChan;Chandef errChan;Chandef htlcSema;Chandef reqQuit;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: htlcSema.async_rcv?0 -> 
		break
	:: htlcSema.sync?0 -> 
		break
	:: reqQuit.async_rcv?0 -> 
		goto stop_process
	:: reqQuit.sync?0 -> 
		goto stop_process
	od;
	

	if
	:: true -> 
		do
		:: errChan.async_send!0 -> 
			break
		:: errChan.sync!0 -> 
			errChan.sending?0;
			break
		:: true -> 
			break
		od;
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			do
			:: errChan.async_send!0 -> 
				break
			:: errChan.sync!0 -> 
				errChan.sending?0;
				break
			:: true -> 
				break
			od
		:: true;
		fi;
		goto stop_process
	fi;
	
	if
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: errChan.async_send!0 -> 
			break
		:: errChan.sync!0 -> 
			errChan.sending?0;
			break
		:: true -> 
			break
		od;
		goto stop_process
	:: true;
	fi;
	wg.Add!-1;
	
	if
	:: htlcSema.async_send!0;
	:: htlcSema.sync!0 -> 
		htlcSema.sending?0
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

