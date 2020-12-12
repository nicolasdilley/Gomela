
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example353702328/uchiwa/daemon/daemon.go
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
	Wgdef wg;
	int i;
	Chandef errCh;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: 1 > 0 -> 
		errCh.size = 1;
		run AsyncChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	wg.Add!7;
	run go_fetchStashes(errCh);
	run go_fetchSilenced(errCh);
	run go_fetchChecks(errCh);
	run go_fetchClients(errCh);
	run go_fetchEvents(errCh);
	run go_fetchInfo(errCh);
	run go_fetchAggregates(errCh);
	
	if
	:: true -> 
		wg.Add!1;
		run go_fetchEnterpriseMetrics(errCh)
	:: true;
	fi;
	run Anonymous8(errCh,wg);
	do
	:: errCh.async_rcv?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: errCh.sync?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	od
stop_process:}

proctype go_fetchStashes(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	int stashes = -2;
	do
	:: true -> 
for10:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
						for(i : 0.. stashes-1) {
for11:
			};
			goto stop_process
		od
	od;
for10_exit:stop_process:
}
proctype go_fetchSilenced(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	int silenced = -2;
	do
	:: true -> 
for20:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
						for(i : 0.. silenced-1) {
for21:
			};
			goto stop_process
		od
	od;
for20_exit:stop_process:
}
proctype go_fetchChecks(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	int checks = -2;
	do
	:: true -> 
for30:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
						for(i : 0.. checks-1) {
for31:
			};
			goto stop_process
		od
	od;
for30_exit:stop_process:
}
proctype go_fetchClients(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	int clients = -2;
	do
	:: true -> 
for40:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
						for(i : 0.. clients-1) {
for41:
			};
			goto stop_process
		od
	od;
for40_exit:stop_process:
}
proctype go_fetchEvents(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	int events = -2;
	do
	:: true -> 
for50:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
						for(i : 0.. events-1) {
for51:
			};
			goto stop_process
		od
	od;
for50_exit:stop_process:
}
proctype go_fetchInfo(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for60:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
			goto stop_process
		od
	od;
for60_exit:stop_process:
}
proctype go_fetchAggregates(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	int aggregates = -2;
	do
	:: true -> 
for70:		do
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
						for(i : 0.. aggregates-1) {
for71:
			};
			goto stop_process
		od
	od;
for70_exit:stop_process:
}
proctype go_fetchEnterpriseMetrics(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous8(Chandef errCh;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
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

