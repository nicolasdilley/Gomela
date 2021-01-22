
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example290140290/api/api.go
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
	Chandef errChan;
	Wgdef sig_waitGroup;
	int num_msgs = 0;
	bool state = false;
	int i;
	run wgMonitor(sig_waitGroup);
	run sync_monitor(errChan);
	run go_Anonymous0(errChan);
	run go_Anonymous3(errChan);
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AcceptConnection0 = [0] of {int};
	run AcceptConnection(errChan,child_AcceptConnection0);
	child_AcceptConnection0?0;
	stop_process: skip
}
proctype AcceptConnection(Chandef errChannel;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef connectionChannel;
	run sync_monitor(connectionChannel);
	run go_Anonymous2(connectionChannel,errChannel);
	do
	:: errChannel.async_rcv?state,num_msgs -> 
		goto stop_process
	:: errChannel.sync?state,num_msgs -> 
		goto stop_process
	:: connectionChannel.async_rcv?state,num_msgs -> 
		goto stop_process
	:: connectionChannel.sync?state,num_msgs -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	stop_process: skip;
	child!0
}
proctype go_Anonymous2(Chandef connectionChannel;Chandef errChannel) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errChannel.async_send!0;
		:: errChannel.sync!false,0 -> 
			errChannel.sending?state
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: connectionChannel.async_send!0;
		:: connectionChannel.sync!false,0 -> 
			connectionChannel.sending?state
		fi
	:: true;
	fi;
	stop_process: skip
}
proctype go_Anonymous3(Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errChan.async_rcv?state,num_msgs;
	:: errChan.sync?state,num_msgs;
	fi;
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

