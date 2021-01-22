
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example236432616/st/server/api.go
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
	chan child_readPump0 = [0] of {int};
	Chandef recv;
	Chandef c_send;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: 256 > 0 -> 
		c_send.size = 256;
		run AsyncChan(c_send)
	:: else -> 
		run sync_monitor(c_send)
	fi;
	run sync_monitor(recv);
	run go_Anonymous0(recv);
	run readPump(recv,child_readPump0);
	child_readPump0?0
stop_process:skip
}

proctype go_Anonymous0(Chandef r) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		do
		:: r.async_rcv?state,num_msgs -> 
			

			if
			:: true -> 
				goto for10_exit
			:: true;
			fi;
			

			if
			:: true -> 
				goto for10_exit
			:: true;
			fi;
			

			if
			:: true -> 
				goto for10_exit
			:: true;
			fi
		:: r.sync?state,num_msgs -> 
			

			if
			:: true -> 
				goto for10_exit
			:: true;
			fi;
			

			if
			:: true -> 
				goto for10_exit
			:: true;
			fi;
			

			if
			:: true -> 
				goto for10_exit
			:: true;
			fi
		od;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip
}
proctype readPump(Chandef r;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for20: skip;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		

		if
		:: r.async_send!0;
		:: r.sync!false,0 -> 
			r.sending?state
		fi;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip;
	

	if
	:: r.async_send!0;
	:: r.sync!false,0 -> 
		r.sending?state
	fi;
	child!0
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

