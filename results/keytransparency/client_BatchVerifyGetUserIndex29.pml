#define BatchVerifyGetUserIndex_runtime_NumCPU6818  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example699315778/core/client/batch_get_and_verify.go
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
	Chandef proofs;
	int runtime_NumCPU6818 = BatchVerifyGetUserIndex_runtime_NumCPU6818;
	Chandef results;
	bool state = false;
	Chandef done;
	Wgdef wg;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(proofs);
	run sync_monitor(done);
	run Anonymous0(proofs,done,results,wg);
	run sync_monitor(results);
	run wgMonitor(wg);
		for(i : 0.. runtime_NumCPU6818-1) {
for20:		wg.Add!1;
		run Anonymous1(proofs,done,results,wg)
	};
for20_exit:	run Anonymous2(proofs,done,results,wg);
	do
	:: results.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	goto stop_process;
	done.closing!true
stop_process:}

proctype Anonymous0(Chandef proofs;Chandef done;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: proofs.async_send!0 -> 
			break
		:: proofs.sync!0 -> 
			proofs.sending?0;
			break
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		od
	:: true -> 
		break
	od;
stop_process:	proofs.closing!true
}
proctype Anonymous1(Chandef proofs;Chandef done;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: proofs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: proofs.async_rcv?0;
			:: proofs.sync?0;
			fi;
			do
			:: results.async_send!0 -> 
				break
			:: results.sync!0 -> 
				results.sending?0;
				break
			:: done.async_rcv?0 -> 
				goto stop_process
			:: done.sync?0 -> 
				goto stop_process
			od
		fi
	od;
stop_process:	wg.Add!-1
}
proctype Anonymous2(Chandef proofs;Chandef done;Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	results.closing!true;
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

