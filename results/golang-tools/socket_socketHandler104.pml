#define ub_for135_1  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example381107728/playground/socket/socket.go
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
	Chandef errc;
	Chandef in;
	Chandef out;
	int num_msgs = 0;
	bool state = false;
	int i;
	run sync_monitor(out);
	run sync_monitor(in);
	

	if
	:: 1 > 0 -> 
		errc.size = 1;
		run AsyncChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	run go_Anonymous0(in,out,errc);
	run go_Anonymous1(in,out,errc);
		for(i : 0.. ub_for135_1) {
		for30: skip;
		do
		:: in.async_rcv?state,num_msgs -> 
			break
		:: in.sync?state,num_msgs -> 
			break
		:: errc.async_rcv?state,num_msgs -> 
			goto stop_process
		:: errc.sync?state,num_msgs -> 
			goto stop_process
		od;
		for30_end: skip
	};
	for30_exit: skip;
	out.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef in;Chandef out;Chandef errc) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: errc.async_send!0;
			:: errc.sync!false,0 -> 
				errc.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: in.async_send!0;
		:: in.sync!false,0 -> 
			in.sending?state
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip
}
proctype go_Anonymous1(Chandef in;Chandef out;Chandef errc) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: out.async_rcv?state,num_msgs;
		:: out.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			

			if
			:: true -> 
				

				if
				:: errc.async_send!0;
				:: errc.sync!false,0 -> 
					errc.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
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

