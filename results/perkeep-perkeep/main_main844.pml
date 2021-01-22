
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example500871849/website/pk-web/pkweb.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef httpsErr;
	chan child_mainstartEmailCommitLoop0 = [0] of {int};
	Chandef emailErr;
	Wgdef logc_loggers;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run wgMonitor(logc_loggers)
		fi
	:: true;
	fi;
	run sync_monitor(emailErr);
	run mainstartEmailCommitLoop(emailErr,child_mainstartEmailCommitLoop0);
	child_mainstartEmailCommitLoop0?0;
	run sync_monitor(httpsErr);
	run go_Anonymous2(emailErr,httpsErr);
	do
	:: emailErr.async_rcv?state,num_msgs -> 
		break
	:: emailErr.sync?state,num_msgs -> 
		break
	:: httpsErr.async_rcv?state,num_msgs -> 
		break
	:: httpsErr.sync?state,num_msgs -> 
		break
	od
stop_process:skip
}

proctype mainstartEmailCommitLoop(Chandef errc;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run go_Anonymous1(errc);
	stop_process: skip;
	child!0
}
proctype go_Anonymous1(Chandef errc) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errc.async_send!0;
	:: errc.sync!false,0 -> 
		errc.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous2(Chandef emailErr;Chandef httpsErr) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: httpsErr.async_send!0;
	:: httpsErr.sync!false,0 -> 
		httpsErr.sending?state
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

proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

