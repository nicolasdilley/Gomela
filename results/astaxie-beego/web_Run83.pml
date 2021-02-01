
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example874439022/server/web/server.go
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
	Chandef endRunning;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		endRunning.size = 1;
		run AsyncChan(endRunning)
	:: else -> 
		run sync_monitor(endRunning)
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run go_Anonymous0(endRunning)
		:: true;
		fi;
		

		if
		:: true -> 
			run go_Anonymous1(endRunning)
		:: true;
		fi;
		

		if
		:: endRunning.async_rcv?state,num_msgs;
		:: endRunning.sync?state,num_msgs;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run go_Anonymous2(endRunning)
	:: true;
	fi;
	

	if
	:: true -> 
		run go_Anonymous3(endRunning)
	:: true;
	fi;
	

	if
	:: endRunning.async_rcv?state,num_msgs;
	:: endRunning.sync?state,num_msgs;
	fi
stop_process:skip
}

proctype go_Anonymous0(Chandef endRunning) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: endRunning.async_send!0;
	:: endRunning.sync!false,0 -> 
		endRunning.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef endRunning) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: endRunning.async_send!0;
	:: endRunning.sync!false,0 -> 
		endRunning.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous2(Chandef endRunning) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		

		if
		:: endRunning.async_send!0;
		:: endRunning.sync!false,0 -> 
			endRunning.sending?state
		fi
	:: true;
	fi;
	stop_process: skip
}
proctype go_Anonymous3(Chandef endRunning) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: endRunning.async_send!0;
			:: endRunning.sync!false,0 -> 
				endRunning.sending?state
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: endRunning.async_send!0;
			:: endRunning.sync!false,0 -> 
				endRunning.sending?state
			fi;
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: endRunning.async_send!0;
			:: endRunning.sync!false,0 -> 
				endRunning.sending?state
			fi
		:: true;
		fi
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
