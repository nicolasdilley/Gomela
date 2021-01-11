#define main_runtime_GOMAXPROCS4118  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example032497123/bench/bench_writer/bench_writer.go
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
	Chandef rdyChan;
	Chandef goChan;
	Wgdef wg;
	bool state = false;
	int i;
	int runtime_GOMAXPROCS4118 = main_runtime_GOMAXPROCS4118;
	run wgMonitor(wg);
	run sync_monitor(goChan);
	run sync_monitor(rdyChan);
		for(i : 0.. runtime_GOMAXPROCS4118-1) {
		for20: skip;
		wg.Add!1;
		run go_Anonymous0(goChan,rdyChan,wg);
		

		if
		:: rdyChan.async_rcv?0;
		:: rdyChan.sync?0;
		fi;
		for20_end: skip
	};
	for20_exit: skip;
	goChan.closing!true;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Chandef goChan;Chandef rdyChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_mainpubWorker0 = [0] of {int};
	run mainpubWorker(rdyChan,goChan,child_mainpubWorker0);
	child_mainpubWorker0?0;
	wg.Add!-1;
	stop_process: skip
}
proctype mainpubWorker(Chandef rdyChan;Chandef goChan;chan child) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: rdyChan.async_send!0;
	:: rdyChan.sync!0 -> 
		rdyChan.sending?0
	fi;
	

	if
	:: goChan.async_rcv?0;
	:: goChan.sync?0;
	fi;
	stop_process: skip;
	child!0
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

