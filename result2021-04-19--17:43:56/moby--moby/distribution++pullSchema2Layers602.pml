#define layers602  -2

// https://github.com/moby/moby/blob/master/distribution/pull_v2.go#L602
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	chan child_pullSchema2Layers6020 = [1] of {int};
	run pullSchema2Layers602(layers602,child_pullSchema2Layers6020)
stop_process:skip
}

proctype pullSchema2Layers602(int layers;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_receiveConfig7893 = [1] of {int};
	chan child_AnonymouspullSchema2Layers7006312 = [1] of {int};
	chan child_receiveConfig7891 = [1] of {int};
	chan child_AnonymouspullSchema2Layers6376280 = [1] of {int};
	Chandef downloadsDone;
	Chandef layerErrChan;
	Chandef configErrChan;
	Chandef configChan;
	

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
	run AnonymouspullSchema2Layers637628(configChan,configErrChan,layerErrChan,downloadsDone,child_AnonymouspullSchema2Layers6376280);
	

	if
	:: true -> 
		run receiveConfig789(configChan,configErrChan,child_receiveConfig7891);
		child_receiveConfig7891?0;
		

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
		run AnonymouspullSchema2Layers700631(downloadsDone,configChan,configErrChan,layerErrChan,child_AnonymouspullSchema2Layers7006312)
	:: true -> 
		downloadsDone.closing!true
	fi;
	

	if
	:: true -> 
		run receiveConfig789(configChan,configErrChan,child_receiveConfig7893);
		child_receiveConfig7893?0;
		

		if
		:: true -> 
			do
			:: downloadsDone.deq?state,num_msgs -> 
				break
			:: downloadsDone.sync?state -> 
				downloadsDone.rcving!false;
				break
			:: layerErrChan.deq?state,num_msgs -> 
				break
			:: layerErrChan.sync?state -> 
				layerErrChan.rcving!false;
				break
			od;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	do
	:: downloadsDone.deq?state,num_msgs -> 
		break
	:: downloadsDone.sync?state -> 
		downloadsDone.rcving!false;
		break
	:: layerErrChan.deq?state,num_msgs -> 
		goto stop_process
	:: layerErrChan.sync?state -> 
		layerErrChan.rcving!false;
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymouspullSchema2Layers637628(Chandef configChan;Chandef configErrChan;Chandef layerErrChan;Chandef downloadsDone;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: configErrChan.enq!0;
		:: configErrChan.sync!false -> 
			configErrChan.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: configChan.enq!0;
	:: configChan.sync!false -> 
		configChan.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype receiveConfig789(Chandef configChan;Chandef errChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: configChan.deq?state,num_msgs -> 
		

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
	:: configChan.sync?state -> 
		configChan.rcving!false;
		

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
	:: errChan.deq?state,num_msgs -> 
		goto stop_process
	:: errChan.sync?state -> 
		errChan.rcving!false;
		goto stop_process
	od;
	stop_process: skip;
	child!0
}
proctype AnonymouspullSchema2Layers700631(Chandef downloadsDone;Chandef configChan;Chandef configErrChan;Chandef layerErrChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: layerErrChan.enq!0;
		:: layerErrChan.sync!false -> 
			layerErrChan.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	downloadsDone.closing!true;
	stop_process: skip;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

