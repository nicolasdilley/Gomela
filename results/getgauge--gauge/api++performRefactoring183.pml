
// https://github.com/getgauge/gauge/blob/13a89591f46d174180de79a2fe3d16030bc9ec10/api/apiMessageHandler.go#L183
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



init { 
	chan child_apiConnectToRunner0 = [0] of {int};
	Chandef c;
	int num_msgs = 0;
	bool state = false;
	int i;
	run sync_monitor(c);
	run apiConnectToRunner(c,child_apiConnectToRunner0);
	child_apiConnectToRunner0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype apiConnectToRunner(Chandef killChannel;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Start0 = [0] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Start(killChannel,child_Start0);
	child_Start0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Start(Chandef killChannel;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runnerStartLegacyRunner0 = [0] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run runnerStartLegacyRunner(killChannel,child_runnerStartLegacyRunner0);
	child_runnerStartLegacyRunner0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype runnerStartLegacyRunner(Chandef killChannel;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef errChannel;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run go_Anonymous3(killChannel);
	run sync_monitor(errChannel);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype go_Anonymous3(Chandef killChannel) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: killChannel.async_rcv?state,num_msgs;
	:: killChannel.sync?state,num_msgs;
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

