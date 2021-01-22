#define ub_for479_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example327401396/pkg/dockerclient/shell.go
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
	Chandef timeoutChan;
	Chandef containerHealthy;
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
		containerHealthy.size = 1;
		run AsyncChan(containerHealthy)
	:: else -> 
		run sync_monitor(containerHealthy)
	fi;
	

	if
	:: true -> 
		

		if
		:: 1 > 0 -> 
			timeoutChan.size = 1;
			run AsyncChan(timeoutChan)
		:: else -> 
			run sync_monitor(timeoutChan)
		fi
	fi;
	run go_Anonymous0(containerHealthy,timeoutChan);
	do
	:: containerHealthy.async_rcv?state,num_msgs -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: containerHealthy.sync?state,num_msgs -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: timeoutChan.async_rcv?state,num_msgs -> 
		goto stop_process
	:: timeoutChan.sync?state,num_msgs -> 
		goto stop_process
	od;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef containerHealthy;Chandef timeoutChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && ub_for479_0 != -2 -> 
				for(i : 0.. ub_for479_0) {
			for101341: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!false,0 -> 
						containerHealthy.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!false,0 -> 
						containerHealthy.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!false,0 -> 
						containerHealthy.sending?state
					fi;
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			for10_end1341: skip
		};
		for10_exit1341: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!false,0 -> 
						containerHealthy.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!false,0 -> 
						containerHealthy.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					

					if
					:: containerHealthy.async_send!0;
					:: containerHealthy.sync!false,0 -> 
						containerHealthy.sending?state
					fi;
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
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

