#define bulkImport_c_workers  ??
#define lb_for120_1  -1
#define ub_for120_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example923217382/cli/silence_import.go
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
	Chandef errc;
	bool state = false;
	int c_workers = bulkImport_c_workers;
	Chandef silencec;
	Wgdef wg;
	int i;
	
	if
	:: true -> 
		
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
	
	if
	:: 100 > 0 -> 
		silencec.size = 100;
		run AsyncChan(silencec)
	:: else -> 
		run sync_monitor(silencec)
	fi;
	
	if
	:: 100 > 0 -> 
		errc.size = 100;
		run AsyncChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	run wgMonitor(wg);
		for(i : 0.. c_workers-1) {
for10:		wg.Add!1;
		run Anonymous0(silencec,errc,wg)
	};
for10_exit:	run Anonymous1(silencec,errc,wg);
	
	if
	:: lb_for120_1 != -2 && ub_for120_2 != -2 -> 
				for(i : lb_for120_1.. ub_for120_2) {
for30:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: silencec.async_send!0;
			:: silencec.sync!0 -> 
				silencec.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: silencec.async_send!0;
			:: silencec.sync!0 -> 
				silencec.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	silencec.closing!true;
	wg.Wait?0;
	errc.closing!true;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef silencec;Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_cliaddSilenceWorker0 = [0] of {int};
	run cliaddSilenceWorker(silencec,errc,child_cliaddSilenceWorker0);
	child_cliaddSilenceWorker0?0;
	wg.Add!-1;
stop_process:
}
proctype Anonymous1(Chandef silencec;Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: errc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errc.async_rcv?0;
			:: errc.sync?0;
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

