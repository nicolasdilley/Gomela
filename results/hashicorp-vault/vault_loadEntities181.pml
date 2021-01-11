#define loadEntities_existing  3
#define loadEntities_consts_ExpirationRestoreWorkerCount  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example911060269/vault/identity_store_util.go
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
	Chandef result;
	Chandef errs;
	Chandef quit;
	Chandef broker;
	bool state = false;
	int i;
	int consts_ExpirationRestoreWorkerCount = loadEntities_consts_ExpirationRestoreWorkerCount;
	int existing = loadEntities_existing;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(broker);
	run sync_monitor(quit);
	

	if
	:: existing > 0 -> 
		errs.size = existing;
		run AsyncChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	

	if
	:: existing > 0 -> 
		result.size = existing;
		run AsyncChan(result)
	:: else -> 
		run sync_monitor(result)
	fi;
	run wgMonitor(wg);
		for(i : 0.. consts_ExpirationRestoreWorkerCount-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(broker,quit,errs,result,wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Add!1;
	run go_Anonymous1(broker,quit,errs,result,wg,existing);
	

	if
	:: 0 != -2 && existing-1 != -3 -> 
				for(i : 0.. existing-1) {
			for30279: skip;
			do
			:: errs.async_rcv?0 -> 
				quit.closing!true;
				goto stop_process
			:: errs.sync?0 -> 
				quit.closing!true;
				goto stop_process
			:: result.async_rcv?0 -> 
				

				if
				:: true -> 
					goto for30_end279
				:: true;
				fi;
				break
			:: result.sync?0 -> 
				

				if
				:: true -> 
					goto for30_end279
				:: true;
				fi;
				break
			od;
			for30_end279: skip
		};
		for30_exit279: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			do
			:: errs.async_rcv?0 -> 
				quit.closing!true;
				goto stop_process
			:: errs.sync?0 -> 
				quit.closing!true;
				goto stop_process
			:: result.async_rcv?0 -> 
				

				if
				:: true -> 
					goto for30_end
				:: true;
				fi;
				break
			:: result.sync?0 -> 
				

				if
				:: true -> 
					goto for30_end
				:: true;
				fi;
				break
			od;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	wg.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef broker;Chandef quit;Chandef errs;Chandef result;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for11: skip;
		do
		:: broker.async_rcv?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errs.async_send!0;
				:: errs.sync!0 -> 
					errs.sending?0
				fi;
				goto for11_end
			:: true;
			fi;
			

			if
			:: result.async_send!0;
			:: result.sync!0 -> 
				result.sending?0
			fi;
			break
		:: broker.sync?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errs.async_send!0;
				:: errs.sync!0 -> 
					errs.sending?0
				fi;
				goto for11_end
			:: true;
			fi;
			

			if
			:: result.async_send!0;
			:: result.sync!0 -> 
				result.sending?0
			fi;
			break
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
			goto stop_process
		od;
		for11_end: skip
	od;
	for11_exit: skip;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Chandef broker;Chandef quit;Chandef errs;Chandef result;Wgdef wg;int existing) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: existing-1 != -3 -> 
				for(i : 0.. existing-1) {
			for20: skip;
			do
			:: quit.async_rcv?0 -> 
				goto stop_process
			:: quit.sync?0 -> 
				goto stop_process
			:: true -> 
				

				if
				:: broker.async_send!0;
				:: broker.sync!0 -> 
					broker.sending?0
				fi
			od;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20276: skip;
			do
			:: quit.async_rcv?0 -> 
				goto stop_process
			:: quit.sync?0 -> 
				goto stop_process
			:: true -> 
				

				if
				:: broker.async_send!0;
				:: broker.sync!0 -> 
					broker.sending?0
				fi
			od;
			for20_end276: skip
		:: true -> 
			break
		od;
		for20_exit276: skip
	fi;
	broker.closing!true;
	stop_process: skip;
	wg.Add!-1
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

proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

