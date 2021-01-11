#define DescribeLogDirs_brokerIds  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example728315321/admin.go
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
	Chandef errChan;
	Chandef logDirsMaps;
	bool state = false;
	int i;
	int brokerIds = DescribeLogDirs_brokerIds;
	

	if
	:: brokerIds > 0 -> 
		logDirsMaps.size = brokerIds;
		run AsyncChan(logDirsMaps)
	:: else -> 
		run sync_monitor(logDirsMaps)
	fi;
	

	if
	:: brokerIds > 0 -> 
		errChan.size = brokerIds;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run wgMonitor(wg);
		for(i : 0.. brokerIds-1) {
		for10: skip;
		wg.Add!1;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
		run go_Anonymous0(logDirsMaps,errChan,wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	logDirsMaps.closing!true;
	errChan.closing!true;
	do
	:: logDirsMaps.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: logDirsMaps.async_rcv?0;
			:: logDirsMaps.sync?0;
			fi;
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef logDirsMaps;Chandef errChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: logDirsMaps.async_send!0;
	:: logDirsMaps.sync!0 -> 
		logDirsMaps.sending?0
	fi;
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

