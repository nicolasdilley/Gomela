#define BatchVerifyGetUserIndex_runtime_NumCPU6818  3

// https://github.com/google/keytransparency/blob/c1d8b03b87f098b18637b89ab17ff4c1c49fd1e2/core/client/batch_get_and_verify.go#L29
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
	Chandef results;
	Chandef done;
	Chandef proofs;
	int num_msgs = 0;
	bool state = false;
	int i;
	int runtime_NumCPU6818 = BatchVerifyGetUserIndex_runtime_NumCPU6818;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(proofs);
	run sync_monitor(done);
	run go_Anonymous0(proofs,done);
	run sync_monitor(results);
	run wgMonitor(wg);
		for(i : 0.. runtime_NumCPU6818-1) {
		for20: skip;
		wg.Add!1;
		run go_Anonymous1(proofs,done,results,wg);
		for20_end: skip
	};
	for20_exit: skip;
	run go_Anonymous2(proofs,done,results,wg);
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
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	goto stop_process;
	done.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef proofs;Chandef done) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int resp_GetProofs5123=3;
	

	if
	:: resp_GetProofs5123-1 != -3 -> 
				for(i : 0.. resp_GetProofs5123-1) {
			for10: skip;
			do
			:: proofs.async_send!0 -> 
				break
			:: proofs.sync!false,0 -> 
				proofs.sending?state;
				break
			:: done.async_rcv?state,num_msgs -> 
				goto stop_process
			:: done.sync?state,num_msgs -> 
				goto stop_process
			od;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for101029: skip;
			do
			:: proofs.async_send!0 -> 
				break
			:: proofs.sync!false,0 -> 
				proofs.sending?state;
				break
			:: done.async_rcv?state,num_msgs -> 
				goto stop_process
			:: done.sync?state,num_msgs -> 
				goto stop_process
			od;
			for10_end1029: skip
		:: true -> 
			break
		od;
		for10_exit1029: skip
	fi;
	stop_process: skip;
	proofs.closing!true
}
proctype go_Anonymous1(Chandef proofs;Chandef done;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: proofs.async_rcv?state,num_msgs;
		:: proofs.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for21: skip;
			do
			:: results.async_send!0 -> 
				break
			:: results.sync!false,0 -> 
				results.sending?state;
				break
			:: done.async_rcv?state,num_msgs -> 
				goto stop_process
			:: done.sync?state,num_msgs -> 
				goto stop_process
			od;
			for21_end: skip
		fi
	od;
	for21_exit: skip;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous2(Chandef proofs;Chandef done;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Wait?0;
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


