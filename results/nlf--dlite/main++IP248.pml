
// https://github.com/nlf/dlite/blob/d0ee08c326039e7c8e8586580fd4536e38ec9fdb/vm.go#L248
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
	Chandef value;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		value.size = 1;
		run AsyncChan(value)
	:: else -> 
		run sync_monitor(value)
	fi;
	run go_Anonymous0(value);
	

	if
	:: value.async_rcv?state,num_msgs;
	:: value.sync?state,num_msgs;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef value) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int blocks=1;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: value.async_send!0;
			:: value.sync!false,0 -> 
				value.sending?state
			fi;
			break
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			

			if
			:: value.async_send!0;
			:: value.sync!false,0 -> 
				value.sending?state
			fi;
			break
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: value.async_send!0;
			:: value.sync!false,0 -> 
				value.sending?state
			fi;
			break
		:: true;
		fi;
		

		if
		:: blocks-1 != -3 -> 
						for(i : 0.. blocks-1) {
				for11: skip;
				

				if
				:: true -> 
					

					if
					:: true -> 
						

						if
						:: value.async_send!0;
						:: value.sync!false,0 -> 
							value.sending?state
						fi;
						break
					:: true;
					fi
				:: true;
				fi;
				for11_end: skip
			};
			for11_exit: skip
		:: else -> 
			do
			:: true -> 
				for11511: skip;
				

				if
				:: true -> 
					

					if
					:: true -> 
						

						if
						:: value.async_send!0;
						:: value.sync!false,0 -> 
							value.sending?state
						fi;
						break
					:: true;
					fi
				:: true;
				fi;
				for11_end511: skip
			:: true -> 
				break
			od;
			for11_exit511: skip
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
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


