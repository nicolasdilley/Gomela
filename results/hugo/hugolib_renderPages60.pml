#define renderPages_numWorkers  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example069599302/hugolib/site_render.go
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
	Chandef pages;
	int i;
	Wgdef wg;
	Chandef results;
	Chandef errs;
	int numWorkers = renderPages_numWorkers;
	bool state = false;
	run sync_monitor(results);
	
	if
	:: numWorkers > 0 -> 
		pages.size = numWorkers;
		run AsyncChan(pages)
	:: else -> 
		run sync_monitor(pages)
	fi;
	run sync_monitor(errs);
	run go_errorCollator(results,errs);
	run wgMonitor(wg);
		for(i : 0.. numWorkers-1) {
for20:		wg.Add!1;
		run go_hugolibpageRenderer(pages,results,wg)
	};
for20_exit:	pages.closing!true;
	wg.Wait?0;
	results.closing!true;
	
	if
	:: errs.async_rcv?0;
	:: errs.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype go_errorCollator(Chandef results;Chandef errs) {
	bool closed; 
	int i;
	bool state;
	do
	:: results.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi
		fi
	od;
	
	if
	:: errs.async_send!0;
	:: errs.sync!0 -> 
		errs.sending?0
	fi;
	errs.closing!true;
stop_process:
}
proctype go_hugolibpageRenderer(Chandef pages;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: pages.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: pages.async_rcv?0;
			:: pages.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: results.async_send!0;
					:: results.sync!0 -> 
						results.sending?0
					fi
				:: true;
				fi
			:: true;
			fi
		fi
	od;
stop_process:	wg.Add!-1
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

