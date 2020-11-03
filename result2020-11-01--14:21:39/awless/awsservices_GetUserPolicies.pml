#define GetUserPolicies_policies_PolicyNames 1
#define GetUserPolicies_attached_AttachedPolicies 1
#define GetUserPolicies_groups_Groups 3
#define GetUserPolicies_output_AttachedPolicies 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example439903794/aws/services/manual_services.go
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
	int groups_Groups = GetUserPolicies_groups_Groups;
	int policies_PolicyNames = GetUserPolicies_policies_PolicyNames;
	int i;
	Chandef errc;
	int attached_AttachedPolicies = GetUserPolicies_attached_AttachedPolicies;
	int output_AttachedPolicies = GetUserPolicies_output_AttachedPolicies;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: 4 > 0 -> 
		errc.size = 4;
		run emptyChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	wg.Add!1;
	run Anonymous0(errc,wg);
	wg.Add!1;
	run Anonymous1(errc,wg);
	wg.Add!1;
	run Anonymous2(errc,wg);
	run Anonymous5(errc,wg);
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
			goto stop_process
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
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
		for(i : 0.. policies_PolicyNames-1) {
for10:
	};
stop_process:	wg.Add!-1
}
proctype Anonymous1(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
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
		for(i : 0.. attached_AttachedPolicies-1) {
for20:
	};
stop_process:	wg.Add!-1
}
proctype Anonymous2(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
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
		for(i : 0.. output_AttachedPolicies-1) {
for31:
	};
stop_process:
}
proctype Anonymous3(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous2(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	Wgdef wgg;
	Chandef resultC;
	
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
	run sync_monitor(resultC);
	run wgMonitor(wgg);
		for(i : 0.. groups_Groups-1) {
for30:		wgg.Add!1;
		run Anonymous2(errc,wg)
	};
	run Anonymous3(errc,wg);
	do
	:: resultC.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: resultC.async_rcv?0;
			:: resultC.sync?0;
			fi
		fi
	od;
stop_process:	wg.Add!-1
}
proctype Anonymous5(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	errc.closing!true;
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


