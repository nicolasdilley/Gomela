#define parallelTest_workers  0
#define parallelTest_fns  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example907264427/test/extended/networking/internal_ports.go
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
	Chandef results;
	Chandef work;
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int workers = parallelTest_workers;
	run wgMonitor(wg);
	

	if
	:: workers > 0 -> 
		work.size = workers;
		run AsyncChan(work)
	:: else -> 
		run sync_monitor(work)
	fi;
	

	if
	:: workers > 0 -> 
		results.size = workers;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
	run go_Anonymous0(work,results,wg);
		for(i : 0.. workers-1) {
		for20: skip;
		run go_Anonymous1(work,results,wg);
		for20_end: skip
	};
	for20_exit: skip;
	do
	:: true -> 
		

		if
		:: results.async_rcv?state,num_msgs;
		:: results.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef work;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int fns = parallelTest_fns;
		for(i : 0.. fns-1) {
		for10: skip;
		

		if
		:: work.async_send!0;
		:: work.sync!false,0 -> 
			work.sending?state
		fi;
		wg.Add!1;
		for10_end: skip
	};
	for10_exit: skip;
	work.closing!true;
	wg.Wait?0;
	results.closing!true;
	stop_process: skip
}
proctype go_Anonymous1(Chandef work;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: work.async_rcv?state,num_msgs;
		:: work.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for21: skip;
			

			if
			:: results.async_send!0;
			:: results.sync!false,0 -> 
				results.sending?state
			fi;
			wg.Add!-1;
			for21_end: skip
		fi
	od;
	for21_exit: skip;
	stop_process: skip
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

