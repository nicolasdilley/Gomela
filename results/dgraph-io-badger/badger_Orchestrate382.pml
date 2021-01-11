#define Orchestrate_st_NumGo  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example936662613/stream.go
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
	Chandef kvErr;
	Wgdef wg;
	Chandef errCh;
	Chandef st_kvChan;
	Chandef st_rangeCh;
	bool state = false;
	int i;
	int st_NumGo = Orchestrate_st_NumGo;
	

	if
	:: 3 > 0 -> 
		st_rangeCh.size = 3;
		run AsyncChan(st_rangeCh)
	:: else -> 
		run sync_monitor(st_rangeCh)
	fi;
	

	if
	:: 32 > 0 -> 
		st_kvChan.size = 32;
		run AsyncChan(st_kvChan)
	:: else -> 
		run sync_monitor(st_kvChan)
	fi;
	

	if
	:: st_NumGo > 0 -> 
		errCh.size = st_NumGo;
		run AsyncChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	run wgMonitor(wg);
		for(i : 0.. st_NumGo-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(st_rangeCh,st_kvChan,errCh,wg);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 1 > 0 -> 
		kvErr.size = 1;
		run AsyncChan(kvErr)
	:: else -> 
		run sync_monitor(kvErr)
	fi;
	run go_Anonymous1(st_rangeCh,st_kvChan,errCh,kvErr,wg);
	wg.Wait?0;
	st_kvChan.closing!true;
	do
	:: errCh.async_rcv?0 -> 
		goto stop_process
	:: errCh.sync?0 -> 
		goto stop_process
	:: true;
	od;
	goto stop_process;
	for20_exit: skip;
	do
	:: st_kvChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: st_kvChan.async_rcv?0;
			:: st_kvChan.sync?0;
			fi;
			for20: skip;
			for20_end: skip
		fi
	od
stop_process:skip
}

proctype go_Anonymous0(Chandef st_rangeCh;Chandef st_kvChan;Chandef errCh;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		do
		:: errCh.async_send!0 -> 
			break
		:: errCh.sync!0 -> 
			errCh.sending?0;
			break
		:: true;
		od
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Chandef st_rangeCh;Chandef st_kvChan;Chandef errCh;Chandef kvErr;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: kvErr.async_send!0;
	:: kvErr.sync!0 -> 
		kvErr.sending?0
	fi;
	stop_process: skip
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

