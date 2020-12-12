#define fanoutForward_wreqs  ??
#define lb_for563_1  -1
#define ub_for563_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example601626616/pkg/receive/handler.go
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
	Wgdef wg;
	Chandef ec;
	int wreqs = fanoutForward_wreqs;
	bool state = false;
	run sync_monitor(ec);
	run wgMonitor(wg);
		for(i : 0.. wreqs-1) {
for10:		wg.Add!1;
		
		if
		:: true -> 
			run Anonymous0(ec,wg)
		:: true;
		fi;
		
		if
		:: true -> 
			run Anonymous1(ec,wg)
		:: true;
		fi;
		run Anonymous2(ec,wg)
	};
	run Anonymous3(ec,wg);
	do
	:: true -> 
for30:		do
		:: ec.async_rcv?0 -> 
			
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
			break
		:: ec.sync?0 -> 
			
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
			break
		od
	od;
for30_exit:	run Anonymous4(ec,wg)
stop_process:}

proctype Anonymous0(Chandef ec;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: ec.async_send!0;
		:: ec.sync!0 -> 
			ec.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: ec.async_send!0;
	:: ec.sync!0 -> 
		ec.sending?0
	fi;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Chandef ec;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: ec.async_send!0;
		:: ec.sync!0 -> 
			ec.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: ec.async_send!0;
	:: ec.sync!0 -> 
		ec.sending?0
	fi;
stop_process:	wg.Add!-1
}
proctype Anonymous2(Chandef ec;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: ec.async_send!0;
		:: ec.sync!0 -> 
			ec.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: ec.async_send!0;
			:: ec.sync!0 -> 
				ec.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: ec.async_send!0;
		:: ec.sync!0 -> 
			ec.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: ec.async_send!0;
	:: ec.sync!0 -> 
		ec.sending?0
	fi;
stop_process:	wg.Add!-1;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi
}
proctype Anonymous3(Chandef ec;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	ec.closing!true;
stop_process:
}
proctype Anonymous4(Chandef ec;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: ec.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: ec.async_rcv?0;
			:: ec.sync?0;
			fi
		fi
	od;
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

