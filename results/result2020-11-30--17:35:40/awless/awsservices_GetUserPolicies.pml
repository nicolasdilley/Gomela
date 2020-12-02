#define GetUserPolicies_groups_Groups  0

// /tmp/clone-example609047689/aws/services/manual_services.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Chandef errc;
	Wgdef wg;
	int groups_Groups = GetUserPolicies_groups_Groups;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: 4 > 0 -> 
		errc.size = 4;
		run AsyncChan(errc)
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
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

