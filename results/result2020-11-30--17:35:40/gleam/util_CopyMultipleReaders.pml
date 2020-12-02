#define CopyMultipleReaders_readers  3

// /tmp/clone-example115657414/util/channel_util.go
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
	Chandef writerChan;
	int i;
	Chandef errChan;
	int readers = CopyMultipleReaders_readers;
	bool state = false;
	
	if
	:: 16 * readers > 0 -> 
		writerChan.size = 16 * readers;
		run AsyncChan(writerChan)
	:: else -> 
		run sync_monitor(writerChan)
	fi;
	
	if
	:: readers > 0 -> 
		errChan.size = readers;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run wgMonitor(wg);
		for(i : 0.. readers-1) {
for10:		wg.Add!1;
		run Anonymous0(writerChan,errChan,wg)
	};
	wg.Add!1;
	run Anonymous1(writerChan,errChan,wg);
	writerChan.closing!true;
	wg.Wait?0;
	goto stop_process;
	errChan.closing!true
stop_process:}

proctype Anonymous0(Chandef writerChan;Chandef errChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: errChan.async_send!0;
	:: errChan.sync!0 -> 
		errChan.sending?0
	fi;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Chandef writerChan;Chandef errChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: writerChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: writerChan.async_rcv?0;
			:: writerChan.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: errChan.async_send!0;
				:: errChan.sync!0 -> 
					errChan.sending?0
				fi;
				break
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

