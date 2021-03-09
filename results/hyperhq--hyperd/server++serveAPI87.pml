#define serveAPI_s_servers  0

// https://github.com/hyperhq/hyperd/blob/8a7e67dc33bbccdfc92b5e2a908bbdb1c5d9b956/server/server.go#L87
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
	Chandef chErrors;
	int num_msgs = 0;
	bool state = false;
	int i;
	int s_servers = serveAPI_s_servers;
	

	if
	:: s_servers > 0 -> 
		chErrors.size = s_servers;
		run AsyncChan(chErrors)
	:: else -> 
		run sync_monitor(chErrors)
	fi;
		for(i : 0.. s_servers-1) {
		for10: skip;
		run go_Anonymous0(chErrors);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && s_servers-1 != -3 -> 
				for(i : 0.. s_servers-1) {
			for20851: skip;
			

			if
			:: chErrors.async_rcv?state,num_msgs;
			:: chErrors.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end851: skip
		};
		for20_exit851: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: chErrors.async_rcv?state,num_msgs;
			:: chErrors.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef chErrors) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: chErrors.async_send!0;
	:: chErrors.sync!false,0 -> 
		chErrors.sending?state
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

