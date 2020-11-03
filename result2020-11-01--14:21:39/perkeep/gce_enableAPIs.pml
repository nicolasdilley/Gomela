#define enableAPIs_list_Services 1
#define enableAPIs_requiredServices 3
#define enableAPIs_gerr_Errors 1
#define lb_for390_3  -1
#define ub_for390_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example826291225/pkg/deploy/gce/deploy.go
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
	int gerr_Errors = enableAPIs_gerr_Errors;
	int list_Services = enableAPIs_list_Services;
	bool state = false;
	Wgdef wg;
	int requiredServices = enableAPIs_requiredServices;
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
		for(i : 0.. list_Services-1) {
for10:
	};
	
	if
	:: requiredServices > 0 -> 
		errc.size = requiredServices;
		run emptyChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	run wgMonitor(wg);
		for(i : 0.. requiredServices-1) {
for20:		
		if
		:: true -> 
			
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
						for(i : 0.. gerr_Errors-1) {
for21:				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			};
			goto stop_process
		:: true;
		fi;
		wg.Add!1;
		run Anonymous0(errc,wg)
	};
	wg.Wait?0;
	errc.closing!true;
	do
	:: errc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errc.async_rcv?0;
			:: errc.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for22:		
		if
		:: true -> 
			
			if
			:: errc.async_send!0;
			:: errc.sync!0 -> 
				errc.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: errc.async_send!0;
			:: errc.sync!0 -> 
				errc.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: errc.async_send!0;
			:: errc.sync!0 -> 
				errc.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		goto stop_process
	od;
for22_exit:stop_process:	wg.Add!-1
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


