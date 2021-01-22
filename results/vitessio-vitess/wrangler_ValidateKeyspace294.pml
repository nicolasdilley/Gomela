
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example983313288/go/vt/wrangler/validator.go
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
	chan child_waitForResults0 = [0] of {int};
	Chandef results;
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(wg);
	

	if
	:: 16 > 0 -> 
		results.size = 16;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
	wg.Add!1;
	run go_Anonymous0(results,wg);
	run waitForResults(wg,results,child_waitForResults0);
	child_waitForResults0?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_validateKeyspace0 = [0] of {int};
	run validateKeyspace(wg,results,child_validateKeyspace0);
	child_validateKeyspace0?0;
	stop_process: skip;
	wg.Add!-1
}
proctype validateKeyspace(Wgdef wg;Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int shards = 3;
	

	if
	:: true -> 
		

		if
		:: results.async_send!0;
		:: results.sync!false,0 -> 
			results.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
		for(i : 0.. shards-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous2(results);
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype go_Anonymous2(Chandef results) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip
}
proctype waitForResults(Wgdef wg;Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	run go_Anonymous4(results);
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
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype go_Anonymous4(Chandef results) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	results.closing!true;
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

