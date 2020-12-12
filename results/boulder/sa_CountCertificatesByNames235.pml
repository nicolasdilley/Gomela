#define CountCertificatesByNames_domains  ??
#define CountCertificatesByNames_ssa_parallelismPerRPC  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example511113049/sa/sa.go
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
	Chandef results;
	int i;
	int domains = CountCertificatesByNames_domains;
	Chandef work;
	Wgdef wg;
	int ssa_parallelismPerRPC = CountCertificatesByNames_ssa_parallelismPerRPC;
	bool state = false;
	
	if
	:: domains > 0 -> 
		work.size = domains;
		run AsyncChan(work)
	:: else -> 
		run sync_monitor(work)
	fi;
	
	if
	:: domains > 0 -> 
		results.size = domains;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
		for(i : 0.. domains-1) {
for10:		
		if
		:: work.async_send!0;
		:: work.sync!0 -> 
			work.sending?0
		fi
	};
	work.closing!true;
	run wgMonitor(wg);
		for(i : 0.. ssa_parallelismPerRPC-1) {
for20:		wg.Add!1;
		run Anonymous0(work,results,wg)
	};
for20_exit:	wg.Wait?0;
	results.closing!true;
	do
	:: results.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
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

proctype Anonymous0(Chandef work;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: work.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: work.async_rcv?0;
			:: work.sync?0;
			fi;
			do
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: results.async_send!0;
			:: results.sync!0 -> 
				results.sending?0
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

