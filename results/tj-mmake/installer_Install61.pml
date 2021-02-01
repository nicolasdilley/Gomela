#define Install_paths  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example117076676/installer/installer.go
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
	Chandef errs;
	Chandef done;
	int num_msgs = 0;
	bool state = false;
	int i;
	int paths = Install_paths;
	

	if
	:: paths > 0 -> 
		done.size = paths;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	

	if
	:: paths > 0 -> 
		errs.size = paths;
		run AsyncChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
		for(i : 0.. paths-1) {
		for10: skip;
		run go_Anonymous0(done,errs);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && paths-1 != -3 -> 
				for(i : 0.. paths-1) {
			for202: skip;
			do
			:: errs.async_rcv?state,num_msgs -> 
				goto stop_process
			:: errs.sync?state,num_msgs -> 
				goto stop_process
			:: done.async_rcv?state,num_msgs -> 
				break
			:: done.sync?state,num_msgs -> 
				break
			od;
			for20_end2: skip
		};
		for20_exit2: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: errs.async_rcv?state,num_msgs -> 
				goto stop_process
			:: errs.sync?state,num_msgs -> 
				goto stop_process
			:: done.async_rcv?state,num_msgs -> 
				break
			:: done.sync?state,num_msgs -> 
				break
			od;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef done;Chandef errs) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errs.async_send!0;
		:: errs.sync!false,0 -> 
			errs.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: done.async_send!0;
	:: done.sync!false,0 -> 
		done.sending?state
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
