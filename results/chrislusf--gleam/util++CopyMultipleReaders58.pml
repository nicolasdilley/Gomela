#define CopyMultipleReaders_readers  0

// https://github.com/chrislusf/gleam/blob/d48afd638bae4e01dbf233e492fc07c840929d45/util/channel_util.go#L58
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
	Chandef errChan;
	Chandef writerChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int readers = CopyMultipleReaders_readers;
	

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
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(writerChan,errChan,wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Add!1;
	run go_Anonymous1(writerChan,errChan,wg);
	

	if
	:: readers-1 != -3 -> 
				for(i : 0.. readers-1) {
			for30: skip;
			

			if
			:: errChan.async_rcv?state,num_msgs;
			:: errChan.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for30173: skip;
			

			if
			:: errChan.async_rcv?state,num_msgs;
			:: errChan.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for30_end173: skip
		:: true -> 
			break
		od;
		for30_exit173: skip
	fi;
	writerChan.closing!true;
	wg.Wait?0;
	goto stop_process;
	errChan.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef writerChan;Chandef errChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errChan.async_send!0;
	:: errChan.sync!false,0 -> 
		errChan.sending?state
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Chandef writerChan;Chandef errChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: writerChan.async_rcv?state,num_msgs;
		:: writerChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			

			if
			:: true -> 
				

				if
				:: errChan.async_send!0;
				:: errChan.sync!false,0 -> 
					errChan.sending?state
				fi;
				break
			:: true;
			fi;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
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

