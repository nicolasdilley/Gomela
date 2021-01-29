#define Start_s_AllowedPendingMessages  3
#define Start_s_MaxTCPConnections  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example784196138/plugins/inputs/statsd/statsd.go
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
	Chandef s_accept;
	Chandef s_done;
	Chandef s_in;
	int num_msgs = 0;
	bool state = false;
	int i;
	int s_MaxTCPConnections = Start_s_MaxTCPConnections;
	int s_AllowedPendingMessages = Start_s_AllowedPendingMessages;
	

	if
	:: s_AllowedPendingMessages > 0 -> 
		s_in.size = s_AllowedPendingMessages;
		run AsyncChan(s_in)
	:: else -> 
		run sync_monitor(s_in)
	fi;
	run sync_monitor(s_done);
	

	if
	:: s_MaxTCPConnections > 0 -> 
		s_accept.size = s_MaxTCPConnections;
		run AsyncChan(s_accept)
	:: else -> 
		run sync_monitor(s_accept)
	fi;
	

	if
	:: 0 != -2 && s_MaxTCPConnections-1 != -3 -> 
				for(i : 0.. s_MaxTCPConnections-1) {
			for10539: skip;
			

			if
			:: s_accept.async_send!0;
			:: s_accept.sync!false,0 -> 
				s_accept.sending?state
			fi;
			for10_end539: skip
		};
		for10_exit539: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: s_accept.async_send!0;
			:: s_accept.sync!false,0 -> 
				s_accept.sending?state
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
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run go_Anonymous0(s_in,s_done,s_accept)
	:: true -> 
		

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
		run go_Anonymous1(s_in,s_done,s_accept)
	fi;
		for(i : 1.. 5) {
		for20: skip;
		run go_Anonymous2(s_in,s_done,s_accept);
		for20_end: skip
	};
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef s_in;Chandef s_done;Chandef s_accept) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip
}
proctype go_Anonymous1(Chandef s_in;Chandef s_done;Chandef s_accept) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip
}
proctype go_Anonymous2(Chandef s_in;Chandef s_done;Chandef s_accept) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

