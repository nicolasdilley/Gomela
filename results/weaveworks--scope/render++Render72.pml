#define Render_l  0
#define Render_r  1
#define ub_for92_2  0

// https://github.com/weaveworks/scope/blob/9aa9b1ae70bc40a765324152debf82e0ae0e2fce/render/render.go#L72
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
	int r = Render_r;
	int l = Render_l;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	fi;
	

	if
	:: l > 0 -> 
		c.size = l;
		run AsyncChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
		for(i : 0.. r-1) {
		for10: skip;
		run go_Anonymous0(c);
		for10_end: skip
	};
	for10_exit: skip;
		for(i : 0.. ub_for92_2) {
		for20: skip;
		

		if
		:: c.async_rcv?state,num_msgs;
		:: c.sync?state,num_msgs;
		fi;
		

		if
		:: c.async_rcv?state,num_msgs;
		:: c.sync?state,num_msgs;
		fi;
		run go_Anonymous1(c);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: c.async_rcv?state,num_msgs;
	:: c.sync?state,num_msgs;
	fi;
	goto stop_process
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
proctype go_Anonymous1(Chandef c) {
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

