#define handleUserQuery_requests  3

// https://github.com/oklog/oklog/blob/ca7cdf51fb41fbc290986e9a24db4fa644ab0714/pkg/store/api.go#L137
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
	Chandef c;
	int num_msgs = 0;
	bool state = false;
	int i;
	int responses=3;
	int requests = handleUserQuery_requests;
	

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
	

	if
	:: requests > 0 -> 
		c.size = requests;
		run AsyncChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
		for(i : 0.. requests-1) {
		for20: skip;
		run go_Anonymous0(c);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && responses-1 != -3 -> 
				for(i : 0.. responses-1) {
			for40450: skip;
			

			if
			:: c.async_rcv?state,num_msgs;
			:: c.sync?state,num_msgs;
			fi;
			for40_end450: skip
		};
		for40_exit450: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: c.async_rcv?state,num_msgs;
			:: c.sync?state,num_msgs;
			fi;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi
stop_process:skip
}

proctype go_Anonymous0(Chandef c) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: c.async_send!0;
	:: c.sync!false,0 -> 
		c.sending?state
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


