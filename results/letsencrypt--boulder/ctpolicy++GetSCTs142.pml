#define GetSCTs_ctp_groups  1
#define GetSCTs_ctp_informational  1

// https://github.com/letsencrypt/boulder/blob/9464d025d1e336ccb5f366e4499ebe9e9596e8d1/ctpolicy/ctpolicy.go#L142
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
	Chandef results;
	int num_msgs = 0;
	bool state = false;
	int i;
	int ctp_informational = GetSCTs_ctp_informational;
	int ctp_groups = GetSCTs_ctp_groups;
	

	if
	:: ctp_groups > 0 -> 
		results.size = ctp_groups;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
		for(i : 0.. ctp_groups-1) {
		for10: skip;
		run go_Anonymous0(results);
		for10_end: skip
	};
	for10_exit: skip;
		for(i : 0.. ctp_informational-1) {
		for20: skip;
		run go_Anonymous1(results);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && ctp_groups-1 != -3 -> 
				for(i : 0.. ctp_groups-1) {
			for30444: skip;
			

			if
			:: results.async_rcv?state,num_msgs;
			:: results.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for30_end444: skip
		};
		for30_exit444: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: results.async_rcv?state,num_msgs;
			:: results.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef results) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: results.async_send!0;
		:: results.sync!false,0 -> 
			results.sending?state
		fi
	:: true;
	fi;
	

	if
	:: results.async_send!0;
	:: results.sync!false,0 -> 
		results.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef results) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
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

