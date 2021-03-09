#define makeConfig_n  0
#define makeConfig_m  1

// https://github.com/fabiolb/fabio/blob/b8d800f880bd4109ad899fb49cf7398f1f90fe33/registry/consul/service.go#L64
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
	Chandef cfgs;
	Chandef sem;
	int num_msgs = 0;
	bool state = false;
	int i;
	int m = makeConfig_m;
	int n = makeConfig_n;
	

	if
	:: n > 0 -> 
		sem.size = n;
		run AsyncChan(sem)
	:: else -> 
		run sync_monitor(sem)
	fi;
	

	if
	:: m > 0 -> 
		cfgs.size = m;
		run AsyncChan(cfgs)
	:: else -> 
		run sync_monitor(cfgs)
	fi;
		for(i : 0.. m-1) {
		for20: skip;
		run go_Anonymous0(sem,cfgs);
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: 0 != -2 && m-1 != -3 -> 
				for(i : 0.. m-1) {
			for301152: skip;
			

			if
			:: cfgs.async_rcv?state,num_msgs;
			:: cfgs.sync?state,num_msgs;
			fi;
			for30_end1152: skip
		};
		for30_exit1152: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: cfgs.async_rcv?state,num_msgs;
			:: cfgs.sync?state,num_msgs;
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

proctype go_Anonymous0(Chandef sem;Chandef cfgs) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: sem.async_send!0;
	:: sem.sync!false,0 -> 
		sem.sending?state
	fi;
	

	if
	:: cfgs.async_send!0;
	:: cfgs.sync!false,0 -> 
		cfgs.sending?state
	fi;
	

	if
	:: sem.async_rcv?state,num_msgs;
	:: sem.sync?state,num_msgs;
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

