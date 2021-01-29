#define ub_for511_0  3
#define ub_for401_2  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example073970218/modules/fswatch/fswatch.go
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
	chan child_DefaultPersistHandlers0 = [0] of {int};
	Chandef configChan;
	Chandef handlerErrChan;
	Chandef regChan;
	Chandef agentAlertChan;
	Chandef logChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 64 > 0 -> 
		logChan.size = 64;
		run AsyncChan(logChan)
	:: else -> 
		run sync_monitor(logChan)
	fi;
	

	if
	:: 64 > 0 -> 
		agentAlertChan.size = 64;
		run AsyncChan(agentAlertChan)
	:: else -> 
		run sync_monitor(agentAlertChan)
	fi;
	

	if
	:: 64 > 0 -> 
		regChan.size = 64;
		run AsyncChan(regChan)
	:: else -> 
		run sync_monitor(regChan)
	fi;
	

	if
	:: 64 > 0 -> 
		handlerErrChan.size = 64;
		run AsyncChan(handlerErrChan)
	:: else -> 
		run sync_monitor(handlerErrChan)
	fi;
	

	if
	:: 1 > 0 -> 
		configChan.size = 1;
		run AsyncChan(configChan)
	:: else -> 
		run sync_monitor(configChan)
	fi;
	

	if
	:: true -> 
		

		if
		:: handlerErrChan.async_send!0;
		:: handlerErrChan.sync!false,0 -> 
			handlerErrChan.sending?state
		fi
	:: true -> 
		

		if
		:: regChan.async_send!0;
		:: regChan.sync!false,0 -> 
			regChan.sending?state
		fi
	fi;
	run go_HandlePersistRequest(handlerErrChan);
	run DefaultPersistHandlers(logChan,handlerErrChan,regChan,agentAlertChan,configChan,child_DefaultPersistHandlers0);
	child_DefaultPersistHandlers0?0
stop_process:skip
}

proctype go_HandlePersistRequest(Chandef errch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		for(i : 0.. ub_for511_0) {
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: errch.async_send!0;
			:: errch.sync!false,0 -> 
				errch.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		run go_Anonymous1(errch);
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip
}
proctype go_Anonymous1(Chandef errch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errch.async_send!0;
		:: errch.sync!false,0 -> 
			errch.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: errch.async_send!0;
		:: errch.sync!false,0 -> 
			errch.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip
}
proctype DefaultPersistHandlers(Chandef logch;Chandef errch;Chandef regch;Chandef alertch;Chandef confch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef inChan;
	

	if
	:: 0 > 0 -> 
		inChan.size = 0;
		run AsyncChan(inChan)
	:: else -> 
		run sync_monitor(inChan)
	fi;
	run go_Anonymous3(inChan,logch,errch,regch,alertch,confch);
		for(i : 0.. ub_for401_2) {
		for30: skip;
		do
		:: errch.async_rcv?state,num_msgs -> 
			run go_Anonymous4(inChan,logch,errch,regch,alertch,confch);
			break
		:: errch.sync?state,num_msgs -> 
			run go_Anonymous4(inChan,logch,errch,regch,alertch,confch);
			break
		:: alertch.async_rcv?state,num_msgs -> 
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi;
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi
		:: alertch.sync?state,num_msgs -> 
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi;
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi
		:: logch.async_rcv?state,num_msgs -> 
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi;
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi
		:: logch.sync?state,num_msgs -> 
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi;
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi
		:: regch.async_rcv?state,num_msgs -> 
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi;
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi
		:: regch.sync?state,num_msgs -> 
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi;
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi
		:: inChan.async_rcv?state,num_msgs -> 
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi
		:: inChan.sync?state,num_msgs -> 
			

			if
			:: true -> 
				goto for30_exit
			:: true;
			fi
		od;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		for30_end: skip
	};
	for30_exit: skip;
	stop_process: skip;
	child!0
}
proctype go_Anonymous3(Chandef inChan;Chandef logch;Chandef errch;Chandef regch;Chandef alertch;Chandef confch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for20: skip;
		

		if
		:: true -> 
			inChan.closing!true;
			break
		:: true;
		fi;
		

		if
		:: inChan.async_send!0;
		:: inChan.sync!false,0 -> 
			inChan.sending?state
		fi;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip
}
proctype go_Anonymous4(Chandef inChan;Chandef logch;Chandef errch;Chandef regch;Chandef alertch;Chandef confch) {
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

