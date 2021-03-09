#define ub_for198_0  -2

// https://github.com/gocircuit/circuit/blob/fd2add79ac1e5c203803f3e845169584c2aafaa5/github.com/miekg/dns/kscan.go#L166
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
	run sync_monitor(c);
	run go_klexer(c);
	do
	:: true -> 
		

		if
		:: c.async_rcv?state,num_msgs;
		:: c.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			

			if
			:: true;
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_klexer(Chandef c) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && ub_for198_0 != -2 -> 
				for(i : 0.. ub_for198_0) {
			for10395: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: c.async_send!0;
					:: c.sync!false,0 -> 
						c.sending?state
					fi
				fi
			:: true;
			:: true -> 
				

				if
				:: c.async_send!0;
				:: c.sync!false,0 -> 
					c.sending?state
				fi
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi
			fi;
			for10_end395: skip
		};
		for10_exit395: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: c.async_send!0;
					:: c.sync!false,0 -> 
						c.sending?state
					fi
				fi
			:: true;
			:: true -> 
				

				if
				:: c.async_send!0;
				:: c.sync!false,0 -> 
					c.sending?state
				fi
			:: true -> 
				

				if
				:: true -> 
					break
				:: true;
				fi
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: true -> 
		

		if
		:: c.async_send!0;
		:: c.sync!false,0 -> 
			c.sending?state
		fi
	:: true;
	fi;
	stop_process: skip;
	c.closing!true
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

