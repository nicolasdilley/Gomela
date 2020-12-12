#define walk_ci_Checkers  ??
#define walk_jobs  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example245167784/fs/walk/walk.go
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
	Chandef errs;
	Wgdef traversing;
	int ci_Checkers = walk_ci_Checkers;
	Wgdef wg;
	Chandef in;
	Chandef quit;
	int jobs = walk_jobs;
	bool state = false;
	run wgMonitor(wg);
	run wgMonitor(traversing);
	
	if
	:: ci_Checkers > 0 -> 
		in.size = ci_Checkers;
		run AsyncChan(in)
	:: else -> 
		run sync_monitor(in)
	fi;
	
	if
	:: 1 > 0 -> 
		errs.size = 1;
		run AsyncChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	run sync_monitor(quit);
		for(i : 0.. ci_Checkers-1) {
for10:		wg.Add!1;
		run Anonymous0(in,errs,quit,wg,traversing)
	};
for10_exit:	traversing.Add!1;
	
	if
	:: in.async_send!0;
	:: in.sync!0 -> 
		in.sending?0
	fi;
	traversing.Wait?0;
	in.closing!true;
	wg.Wait?0;
	errs.closing!true;
	
	if
	:: errs.async_rcv?0;
	:: errs.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef in;Chandef errs;Chandef quit;Wgdef wg;Wgdef traversing) {
	bool closed; 
	int i;
	bool state;
		for(i : lb_for389_2.. ub_for389_3) {
for11:		do
		:: in.async_rcv?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				traversing.Add!-1;
				do
				:: errs.async_send!0 -> 
					break
				:: errs.sync!0 -> 
					errs.sending?0;
					break
				:: true -> 
					break
				od
			:: true;
			fi;
			
			if
			:: true -> 
				traversing.Add!jobs;
				run Anonymous0(in,errs,quit,wg,traversing)
			:: true;
			fi;
			traversing.Add!-1;
			break
		:: in.sync?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				traversing.Add!-1;
				do
				:: errs.async_send!0 -> 
					break
				:: errs.sync!0 -> 
					errs.sending?0;
					break
				:: true -> 
					break
				od
			:: true;
			fi;
			
			if
			:: true -> 
				traversing.Add!jobs;
				run Anonymous0(in,errs,quit,wg,traversing)
			:: true;
			fi;
			traversing.Add!-1;
			break
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
			goto stop_process
		od
	};
for11_exit:stop_process:	wg.Add!-1
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

