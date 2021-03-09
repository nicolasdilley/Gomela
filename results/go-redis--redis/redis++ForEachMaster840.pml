#define ForEachMaster_state_Masters  3

// https://github.com/go-redis/redis/blob/aa456e55a7213876dfa5e856fb8467237d822771/cluster.go#L840
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
	Chandef errCh;
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int state_Masters = ForEachMaster_state_Masters;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	

	if
	:: 1 > 0 -> 
		errCh.size = 1;
		run AsyncChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
		for(i : 0.. state_Masters-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(errCh,wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	do
	:: errCh.async_rcv?state,num_msgs -> 
		goto stop_process
	:: errCh.sync?state,num_msgs -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:skip
}

proctype go_Anonymous0(Chandef errCh;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		do
		:: errCh.async_send!0 -> 
			break
		:: errCh.sync!false,0 -> 
			errCh.sending?state;
			break
		:: true;
		od
	:: true;
	fi;
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

