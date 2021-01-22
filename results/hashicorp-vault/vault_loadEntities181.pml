#define loadEntities_existing  3
#define loadEntities_consts_ExpirationRestoreWorkerCount  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example936276566/vault/identity_store_util.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
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
	int num_msgs = 0;
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
			for30281: skip;
			do
			:: errs.async_rcv?state,num_msgs -> 
				quit.closing!true;
				goto stop_process
			:: errs.sync?state,num_msgs -> 
				quit.closing!true;
				goto stop_process
			:: result.async_rcv?state,num_msgs -> 
				

				if
				:: true -> 
					goto for30_end281
				:: true;
				fi;
				break
			:: result.sync?state,num_msgs -> 
				

				if
				:: true -> 
					goto for30_end281
				:: true;
				fi;
				break
			od;
			for30_end281: skip
		};
		for30_exit281: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			do
			:: errs.async_rcv?state,num_msgs -> 
				quit.closing!true;
				goto stop_process
			:: errs.sync?state,num_msgs -> 
				quit.closing!true;
				goto stop_process
			:: result.async_rcv?state,num_msgs -> 
				

				if
				:: true -> 
					goto for30_end
				:: true;
				fi;
				break
			:: result.sync?state,num_msgs -> 
				

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
	int num_msgs;
	do
	:: true -> 
		for11: skip;
		do
		:: broker.async_rcv?state,num_msgs -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errs.async_send!0;
				:: errs.sync!false,0 -> 
					errs.sending?state
				fi;
				goto for11_end
			:: true;
			fi;
			

			if
			:: result.async_send!0;
			:: result.sync!false,0 -> 
				result.sending?state
			fi;
			break
		:: broker.sync?state,num_msgs -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errs.async_send!0;
				:: errs.sync!false,0 -> 
					errs.sending?state
				fi;
				goto for11_end
			:: true;
			fi;
			

			if
			:: result.async_send!0;
			:: result.sync!false,0 -> 
				result.sending?state
			fi;
			break
		:: quit.async_rcv?state,num_msgs -> 
			goto stop_process
		:: quit.sync?state,num_msgs -> 
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
	int num_msgs;
	

	if
	:: existing-1 != -3 -> 
				for(i : 0.. existing-1) {
			for20: skip;
			do
			:: quit.async_rcv?state,num_msgs -> 
				goto stop_process
			:: quit.sync?state,num_msgs -> 
				goto stop_process
			:: true -> 
				

				if
				:: broker.async_send!0;
				:: broker.sync!false,0 -> 
					broker.sending?state
				fi
			od;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20278: skip;
			do
			:: quit.async_rcv?state,num_msgs -> 
				goto stop_process
			:: quit.sync?state,num_msgs -> 
				goto stop_process
			:: true -> 
				

				if
				:: broker.async_send!0;
				:: broker.sync!false,0 -> 
					broker.sending?state
				fi
			od;
			for20_end278: skip
		:: true -> 
			break
		od;
		for20_exit278: skip
	fi;
	broker.closing!true;
	stop_process: skip;
	wg.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
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

