#define main_runtime_GOMAXPROCS4118  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example934849260/bench/bench_writer/bench_writer.go
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
	Chandef rdyChan;
	Chandef goChan;
	Wgdef wg;
	int num_msgs = 0;
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
		:: rdyChan.async_rcv?state,num_msgs;
		:: rdyChan.sync?state,num_msgs;
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
	int num_msgs;
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
	int num_msgs;
	

	if
	:: rdyChan.async_send!0;
	:: rdyChan.sync!false,0 -> 
		rdyChan.sending?state
	fi;
	

	if
	:: goChan.async_rcv?state,num_msgs;
	:: goChan.sync?state,num_msgs;
	fi;
	stop_process: skip;
	child!0
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

