
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example077972819/distribution/pull_v2.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	chan child_distributionreceiveConfig1 = [0] of {int};
	chan child_distributionreceiveConfig0 = [0] of {int};
	Chandef downloadsDone;
	Chandef layerErrChan;
	Chandef configErrChan;
	Chandef configChan;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		configChan.size = 1;
		run AsyncChan(configChan)
	:: else -> 
		run sync_monitor(configChan)
	fi;
	

	if
	:: 1 > 0 -> 
		configErrChan.size = 1;
		run AsyncChan(configErrChan)
	:: else -> 
		run sync_monitor(configErrChan)
	fi;
	

	if
	:: 1 > 0 -> 
		layerErrChan.size = 1;
		run AsyncChan(layerErrChan)
	:: else -> 
		run sync_monitor(layerErrChan)
	fi;
	run sync_monitor(downloadsDone);
	run go_Anonymous0(configChan,configErrChan,layerErrChan,downloadsDone);
	

	if
	:: true -> 
		run distributionreceiveConfig(configChan,configErrChan,child_distributionreceiveConfig0);
		child_distributionreceiveConfig0?0;
		

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
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		run go_Anonymous2(configChan,configErrChan,layerErrChan,downloadsDone)
	:: true -> 
		downloadsDone.closing!true
	:: true -> 
		downloadsDone.closing!true
	fi;
	

	if
	:: true -> 
		run distributionreceiveConfig(configChan,configErrChan,child_distributionreceiveConfig1);
		child_distributionreceiveConfig1?0;
		

		if
		:: true -> 
			do
			:: downloadsDone.async_rcv?0 -> 
				break
			:: downloadsDone.sync?0 -> 
				break
			:: layerErrChan.async_rcv?0 -> 
				break
			:: layerErrChan.sync?0 -> 
				break
			od;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	do
	:: downloadsDone.async_rcv?0 -> 
		break
	:: downloadsDone.sync?0 -> 
		break
	:: layerErrChan.async_rcv?0 -> 
		goto stop_process
	:: layerErrChan.sync?0 -> 
		goto stop_process
	od;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef configChan;Chandef configErrChan;Chandef layerErrChan;Chandef downloadsDone) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: configErrChan.async_send!0;
		:: configErrChan.sync!0 -> 
			configErrChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: configChan.async_send!0;
	:: configChan.sync!0 -> 
		configChan.sending?0
	fi;
	stop_process: skip
}
proctype distributionreceiveConfig(Chandef configChan;Chandef errChan;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: configChan.async_rcv?0 -> 
		

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
		goto stop_process
	:: configChan.sync?0 -> 
		

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
		goto stop_process
	:: errChan.async_rcv?0 -> 
		goto stop_process
	:: errChan.sync?0 -> 
		goto stop_process
	od;
	stop_process: skip;
	child!0
}
proctype go_Anonymous2(Chandef configChan;Chandef configErrChan;Chandef layerErrChan;Chandef downloadsDone) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: layerErrChan.async_send!0;
		:: layerErrChan.sync!0 -> 
			layerErrChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	downloadsDone.closing!true;
	stop_process: skip
}
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

