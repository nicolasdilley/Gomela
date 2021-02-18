#define GetPluginDescriptions_plugins  3

// https://github.com/juju/juju/blob/af21dceaf489e65417c11a49921a03bf188480cd/cmd/juju/commands/plugin.go#L147
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
	Chandef description;
	int num_msgs = 0;
	bool state = false;
	int i;
	int plugins = GetPluginDescriptions_plugins;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: plugins > 0 -> 
		description.size = plugins;
		run AsyncChan(description)
	:: else -> 
		run sync_monitor(description)
	fi;
		for(i : 0.. plugins-1) {
		for10: skip;
		run go_Anonymous0(description);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: plugins-1 != -3 -> 
				for(i : 0.. plugins-1) {
			for20: skip;
			

			if
			:: description.async_rcv?state,num_msgs;
			:: description.sync?state,num_msgs;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20308: skip;
			

			if
			:: description.async_rcv?state,num_msgs;
			:: description.sync?state,num_msgs;
			fi;
			for20_end308: skip
		:: true -> 
			break
		od;
		for20_exit308: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef description) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	

	if
	:: description.async_send!0;
	:: description.sync!false,0 -> 
		description.sending?state
	fi
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

